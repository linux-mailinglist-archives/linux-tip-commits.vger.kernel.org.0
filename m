Return-Path: <linux-tip-commits+bounces-1474-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DC5910321
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Jun 2024 13:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D551F22269
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Jun 2024 11:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF591AB91A;
	Thu, 20 Jun 2024 11:36:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46439FD7;
	Thu, 20 Jun 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883413; cv=none; b=iH342SvzPN/Vhwd4SLhgYfxUJbnWLQcaaSlGzIHpHekF4X0LrDcMXWRK1DMIYwkJCbT1gOqUACGlmhlMkIXyxh5zE9qU1gZx+yzIFxsw8NWJ83P1F/WKfD+qCx0zXDSKrmiqHzppZ2xWetYzxLFqdhdAQwjflVTVWngjpQSd8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883413; c=relaxed/simple;
	bh=yKMdN4mgeSJWVWyiv46KXqPiWOGWA5iwguABvHUDFfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPox8iLgD85fOwk7SYAulJHvG4BeXnlFYMs6vIRupbhG3EavusdVmbIv8dUW+1EI78pktKuuShZfZ+jSG78xXzhS9vrejtdjepPLHdSRfot7CqfFGFQ+6p+kVlv0BvhGztJQxPHPDt7tOHJar8EYU9vc3DV7e8ATelcMzU2Ju+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E86A11042;
	Thu, 20 Jun 2024 04:37:14 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 755923F6A8;
	Thu, 20 Jun 2024 04:36:49 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:36:43 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-tip-commits@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/urgent] x86/resctrl: Don't try to free nonexistent
 RMIDs
Message-ID: <ZnQUS+xchr13/3jk@e133380.arm.com>
References: <20240618140152.83154-1-Dave.Martin@arm.com>
 <171879092443.10875.1695191697085701044.tip-bot2@tip-bot2>
 <ZnLUVtZ3oaFjcUj9@e133380.arm.com>
 <20240619134522.GCZnLg8pgJq9MPHS8M@fat_crate.local>
 <ZnMBN487xiPOfpRp@e133380.arm.com>
 <20240619162124.GFZnMFhPW3wo2Avezo@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619162124.GFZnMFhPW3wo2Avezo@fat_crate.local>

Hi,

On Wed, Jun 19, 2024 at 06:21:24PM +0200, Borislav Petkov wrote:
> On Wed, Jun 19, 2024 at 05:03:03PM +0100, Dave Martin wrote:
> > It's still a guideline, no?  (Though I admit that common sense has to
> > apply and there are quite often good reasons to bust the limit in
> > code.)  But commit messages are not code, and don't suffer from
> > creeping indentation that eats up half of each line, so the rationale
> > is not really the same.
> 
> Just do a "git log" on mainline and marvel at all the possible "formatting".
> 
> The ship on being able to read commit messages with formatting that fits what
> you're expecting has long sailed.

Well, not exactly "expecting", but unfamiliar.  I've mostly been living
in in arch/arm{,64}/ where it's common to have lines a little shorter.

> > Anyway, I was just mildly surprised, it's not a huge deal.
> 
> Yeah, we don't have a strict rule. And I don't think you can make everyone
> agree and then adhere to some rule for commit messages width. But hey... :-)
> 
> > (Quoted: "Text-based e-mail should not exceed 80 columns per line of
> > text.  Consult the documentation of your e-mail client to enable proper
> > line breaks around column 78.".  No statement about commit messages,
> > and "should not exceed" is not the same as "should be wrapped to".
> > This document doesn't seem to consider how git formats text derived
> > from emails.)
> 
> See above.
> 
> I'm willing to consider a rule for commit messages if the majority agrees on
> some rule.
> 
> Thx.

I guess my issue is that the "Massage commit message" seems to document
a criticism that the author was careless, didn't follow a rule, or that
the commit message was defective in some way, with the author having no
right of reply (at least, not recorded in the git history).

I may just be being too touchy.

Anyway, thanks for picking up the patch -- I'm not trying to make extra
work for anyone.

Cheers
---Dave

