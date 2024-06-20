Return-Path: <linux-tip-commits+bounces-1476-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A0F910450
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Jun 2024 14:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9741B1F2168E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Jun 2024 12:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246CB1AC453;
	Thu, 20 Jun 2024 12:38:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCCA1AC451;
	Thu, 20 Jun 2024 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887127; cv=none; b=M37kwUA3GZszfhmDaq1tsF2qG76a6mnaIEpEVqh9fHft60fZDTS/7tRkCCpFZrWG1mHuIm72Xkwp4ld2a3OKpZVQ5c+nLNUDfAbj8PSYRQjTTYWWbgsBGADkiJDhu6l8OaIj1EZL/D46YzorkHnHUglyZt7tgTi0Ha/kU9+O/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887127; c=relaxed/simple;
	bh=MYZc8VcOMHW0zW/O1qd63wSKJQy0yho9ouViyflAf4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+tmzWioqFXcemjTtuC1sdqwwb1zzeuuJFUSNrA44rBWKk31+iHsl+NhoX9XjR2nfVnudUniUAXJknf1VhbqZxywhkhqFEmXto77u0WUTWEUDQ+xJwjBNRdYHy6yFJPdhol7+eiyj9wEIffsHLP83K5c8rfZBBSA+LZYfoox7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3CEBDA7;
	Thu, 20 Jun 2024 05:39:07 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 508003F73B;
	Thu, 20 Jun 2024 05:38:42 -0700 (PDT)
Date: Thu, 20 Jun 2024 13:38:39 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-tip-commits@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/urgent] x86/resctrl: Don't try to free nonexistent
 RMIDs
Message-ID: <ZnQizwOWjsIbj6TR@e133380.arm.com>
References: <20240618140152.83154-1-Dave.Martin@arm.com>
 <171879092443.10875.1695191697085701044.tip-bot2@tip-bot2>
 <ZnLUVtZ3oaFjcUj9@e133380.arm.com>
 <20240619134522.GCZnLg8pgJq9MPHS8M@fat_crate.local>
 <ZnMBN487xiPOfpRp@e133380.arm.com>
 <20240619162124.GFZnMFhPW3wo2Avezo@fat_crate.local>
 <ZnQUS+xchr13/3jk@e133380.arm.com>
 <20240620115305.GBZnQYIex1mnXxoG-8@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620115305.GBZnQYIex1mnXxoG-8@fat_crate.local>

On Thu, Jun 20, 2024 at 01:53:05PM +0200, Borislav Petkov wrote:
> On Thu, Jun 20, 2024 at 12:36:43PM +0100, Dave Martin wrote:
> > I guess my issue is that the "Massage commit message" seems to document
> > a criticism that the author was careless, didn't follow a rule, or that
> > the commit message was defective in some way, with the author having no
> > right of reply (at least, not recorded in the git history).
> 
> Not necessarily - that's what you said. I massage commit messages because they
> need some touch ups sometimes.
> 
> In your case I rewrote the sentence with "we" because "we" is ambiguous in

That _was_ unintentional, so apologies for that.

> commit messages. I also broke up this biggish paragraph into smaller chunks to
> make it more readable.
> 
> > I may just be being too touchy.
> > 
> > Anyway, thanks for picking up the patch -- I'm not trying to make extra
> > work for anyone.
> 
> I look at it this way: I don't always agree with other maintainers' choices
> either but this is the reality: every maintainer has their own
> requirements/views/etc on how the code and commit messages are going to look,
> yadda yadda. And to some extent that's their prerogative.
> 
> But we have a *lot* *bigger* fish to fry so I'm going to stop debating here as
> everything was already said.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 

Ack; apologies for the noise.

Cheers
---Dave

