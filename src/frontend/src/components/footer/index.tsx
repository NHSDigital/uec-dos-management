import React from 'react';
import { Footer as NhsFooter } from "nhsuk-react-components";
import { FooterProps } from './interface';

const Footer: React.FC<FooterProps> = ({ buildDate, commitHash }) => {
  return (
    <NhsFooter data-testid='footer'>
      <p className="nhsuk-body-s" data-testid='build-details'>Version {commitHash} - {buildDate}</p>
    </NhsFooter>
  );
};

export default Footer;
