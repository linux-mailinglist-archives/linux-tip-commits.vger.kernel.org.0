Return-Path: <linux-tip-commits+bounces-1475-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD15910377
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Jun 2024 13:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891C8B23843
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Jun 2024 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AB9172BB2;
	Thu, 20 Jun 2024 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UMszkk9g"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019EB1ACE71;
	Thu, 20 Jun 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884413; cv=none; b=mmCHZlse/eLHmBk9oTwYd4lU0GAYQbLGd07GP46oFWDbeEQbzDVaSfHpwrgqeWCW9+1HhrwW4lelaaRDx1xZ5Vz1Mky6wv8b24Mc9ucdXU+Z7moVdCZROC8f6HXn9LtIWJSYF2rC0xSwY63cu3Y8vABfDXXgCivwmRrhiP20QlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884413; c=relaxed/simple;
	bh=mOpz0xLCblfkhTGF64HsJ7bRAzWW9g2Dc6f35XH9tsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISdKOZtxSJPvGmT8Rw6i2+0+ZPGWZQ1RTCinyMtJTLLpJJ1febi7wMPULoza5kpGXtr4WfIMjkucPiwG7RK/jhz/b8Ik/1WE7ZTlQ5hV4Mu8TZmCHgUTfobnYcawn1IiCT+9S64ZHYcftK5M8PYVm7dpt7ZuGXagncBZALzPYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UMszkk9g; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1C33740E021A;
	Thu, 20 Jun 2024 11:53:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4W9CGPoDkBJb; Thu, 20 Jun 2024 11:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718884396; bh=ZqD8vmrHSBWXXg4q2P0/d4xFnee0YAecpv60uVJ/izk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UMszkk9gFemHmYI8JdNT35C2sQJRR+NT+6Z/CY8ko2kFwOG1C9Ns5rh75ni3mnobE
	 pymGpD9/cj4MA1XWrHUou8Bze7TjuxZq8C9zRK/ht/bOooalV+X4oN6POIdytSRvxO
	 bpR+q2bTZ77Vpexr2TjUDHmkbF0dUeIeIkKQEi2P0T3I9GnrF8xp1NiwSNUJvqO3MV
	 ca6vRq0oYvXzFJRJNAnJKvy6OHUFtKZSRqeN7diICkuTIi94hC2YIDGgaVRhf+n6mA
	 B2qhLJjRJ/Wi/6VSB5+cmWq9X+TxRcgsH77tgUDnh3he1ZRiVIoZ8GNLJM+85LLf60
	 wx4umVsOE1lJiiG+QumY4TMOXy4ZJsY/P8jG/IPToopmhuKBQiw1L4pxF6RLqc1mOq
	 V14biI0P1hHlDhR62goWdEDhGR91V7nL6dTaGacbSdOfkHVZL/gKDYyB94QLuImVmI
	 M1KiIJ2Vsa5ttPln6x/pr/qhHgLIQydSfcZCam9L+Yka6730tW16l8kFz01sDG4D/t
	 ZGNtdLuxaJ6z9SLFEB6pZeSjvaU/3sxDTwalATjUKgMGvKln745EBr/JrSz8naEMTm
	 j7K0k7sHUIEWvRCksunjU/iKFHQWM4Ghf3dU/q9QmZOODopBBGmAbB2lj1Mo2eek4G
	 obJlBHnLfS6Eo79s878A/3Dk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92BA840E0177;
	Thu, 20 Jun 2024 11:53:11 +0000 (UTC)
Date: Thu, 20 Jun 2024 13:53:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-tip-commits@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/urgent] x86/resctrl: Don't try to free nonexistent
 RMIDs
Message-ID: <20240620115305.GBZnQYIex1mnXxoG-8@fat_crate.local>
References: <20240618140152.83154-1-Dave.Martin@arm.com>
 <171879092443.10875.1695191697085701044.tip-bot2@tip-bot2>
 <ZnLUVtZ3oaFjcUj9@e133380.arm.com>
 <20240619134522.GCZnLg8pgJq9MPHS8M@fat_crate.local>
 <ZnMBN487xiPOfpRp@e133380.arm.com>
 <20240619162124.GFZnMFhPW3wo2Avezo@fat_crate.local>
 <ZnQUS+xchr13/3jk@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnQUS+xchr13/3jk@e133380.arm.com>

On Thu, Jun 20, 2024 at 12:36:43PM +0100, Dave Martin wrote:
> I guess my issue is that the "Massage commit message" seems to document
> a criticism that the author was careless, didn't follow a rule, or that
> the commit message was defective in some way, with the author having no
> right of reply (at least, not recorded in the git history).

Not necessarily - that's what you said. I massage commit messages because they
need some touch ups sometimes.

In your case I rewrote the sentence with "we" because "we" is ambiguous in
commit messages. I also broke up this biggish paragraph into smaller chunks to
make it more readable.

> I may just be being too touchy.
> 
> Anyway, thanks for picking up the patch -- I'm not trying to make extra
> work for anyone.

I look at it this way: I don't always agree with other maintainers' choices
either but this is the reality: every maintainer has their own
requirements/views/etc on how the code and commit messages are going to look,
yadda yadda. And to some extent that's their prerogative.

But we have a *lot* *bigger* fish to fry so I'm going to stop debating here as
everything was already said.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

