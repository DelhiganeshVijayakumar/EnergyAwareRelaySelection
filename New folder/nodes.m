clf;
%coordinates
source = [2,2]; 
destination = [8,8]; 
relay1 = [3,6];
relay2 = [4,5];  
relay3= [6,3];
relay4 = [6,5];
eavedropper=[2,8];

scatter(source(1), source(2), 100, 'o', 'filled');  
hold on;
scatter(destination(1), destination(2), 100, 'o', 'filled'); 
scatter(relay1(1), relay1(2), 100, 's', 'filled');  
scatter(relay2(1), relay2(2), 100, 's', 'filled');  
scatter(relay3(1), relay3(2), 100, 's', 'filled');  
scatter(relay4(1), relay4(2), 100, 's', 'filled');
%scatter(relay5(1), relay5(2), 100, 's', 'filled');
scatter(eavedropper(1), eavedropper(2), 100, 'diamond','red','filled');
% 
xlabel('Distance(km)');
ylabel('Distance(km)');


axis([1 10 1 10]);
text(source(1), source(2) - 0.05, 'Source', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 8);
text(destination(1), destination(2) - 0.05, 'Destination', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 8);
text(relay1(1), relay1(2) + 0.05, 'relay 1', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 8);
text(relay2(1), relay2(2) + 0.05, 'relay 2', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 8);
text(relay3(1), relay3(2) - 0.05, 'relay 3', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 8);
text(relay4(1), relay4(2) - 0.05, 'relay 4', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 8);

text(eavedropper(1), eavedropper(2) - 0.05, 'eavedropper', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 8);
plot([relay3(1),destination(1)],[relay3(2),destination(2)],'b-', 'LineWidth', 1);
plot([relay1(1),destination(1)],[relay1(2),destination(2)],'g-', 'LineWidth', 1);
plot([relay2(1),destination(1)],[relay2(2),destination(2)],'o-', 'LineWidth', 1);
plot([relay4(1),destination(1)],[relay4(2),destination(2)],'k-', 'LineWidth', 1);

plot([relay2(1),source(1)],[relay2(2),source(2)],'o-', 'LineWidth', 1);
plot([relay3(1),source(1)],[relay3(2),source(2)],'b-', 'LineWidth', 1);
plot([relay4(1),source(1)],[relay4(2),source(2)],'k-', 'LineWidth', 1);
plot([relay1(1),source(1)],[relay1(2),source(2)],'g-', 'LineWidth', 1);

plot([relay2(1),eavedropper(1)],[relay2(2),eavedropper(2)],'r--', 'LineWidth', 1);
plot([relay3(1),eavedropper(1)],[relay3(2),eavedropper(2)],'r--', 'LineWidth', 1);
plot([relay4(1),eavedropper(1)],[relay4(2),eavedropper(2)],'r--', 'LineWidth', 1);
plot([relay1(1),eavedropper(1)],[relay1(2),eavedropper(2)],'r--', 'LineWidth', 1);
