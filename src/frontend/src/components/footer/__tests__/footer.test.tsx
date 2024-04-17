import React from 'react';
import { render, screen } from '@testing-library/react';
import Footer from '..';

describe('Footer', () => {
  it('should render footer component with build version and date', () => {
    const buildDate = "2022-01-01";
    const commitHash = "xxxxxxxxxxxxxxxxxx";

    render(<Footer buildDate={buildDate} commitHash={commitHash} />);

    expect(screen.getByTestId('footer')).toBeInTheDocument();
    expect(screen.getByTestId('build-details')).toHaveTextContent(`Version ${commitHash} - ${buildDate}`);
  });
});
