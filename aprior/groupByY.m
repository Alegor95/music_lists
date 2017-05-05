function [ grupped ] = groupByY( linesStruct, groupSize )
  tmp = [linesStruct.point1];
  tmp = tmp(2:2:length(tmp));
  [sorted,ix]=sort(tmp);
  lines=linesStruct(ix);
  groupsCount = 0;
  currentGroup = zeros(groupSize, 1);  
  inGroup = 0;
  grupped = zeros(length(linesStruct), 1);
  metric = @(x1, x2)abs(x1 - x2);
  for i = 1 : length(lines)
      line = lines(i);
      firstDist = 0;
      currentDist = 0;
      if (inGroup > 0)
          if (inGroup > 1)
            firstDist = metric(lines(currentGroup(1)).point1(2), lines(currentGroup(2)).point1(2));            
          end;
          currentDist = metric(line.point1(2), lines(currentGroup(inGroup)).point1(2));
      end;      
      if (inGroup < groupSize)
          %Если в группе меньше 5 линий, добавляем в любом случае
          inGroup = inGroup + 1;
          currentGroup(inGroup) = i;
      elseif firstDist > currentDist
          firstDist, currentDist, currentGroup
          currentGroup = vertcat(currentGroup(2:groupSize), zeros(1,1));
          currentGroup(groupSize) = i;
          currentGroup
      else
          currentGroup
          %Смотрим, собралась ли группа
          groupsCount = groupsCount + 1;
          for j=1:groupSize
              grupped(ix(currentGroup(j))) = groupsCount;
          end;
          currentGroup = zeros(groupSize, 1);
          inGroup = 1;
          currentGroup(inGroup) = i;
      end;
  end;
  %Если есть готовая группа, которую не добавило
  if inGroup == groupSize
      groupsCount = groupsCount + 1;
          for j=1:groupSize
              grupped(ix(currentGroup(j))) = groupsCount;
          end;
  end;
end

