Return-Path: <linux-tip-commits+bounces-1470-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40B090F3A4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 18:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4633D281EB7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5945D152E03;
	Wed, 19 Jun 2024 16:03:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BDC153810;
	Wed, 19 Jun 2024 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812989; cv=none; b=ME6QDeLBbgBjcZycloMgeQ82IAhOtpi4+joX3eav0ouSvLj2n0PSPAXQQhCObbg70i49fnXBsKc3e0++nb1ac0KRNkmLmbJZCvXeT8ImE2sm6zbcoUU+w/oans6PjJ0lMCyCfw1VZqYe9qyZH2xd2/FeJXnY/FWSKM2Lef/B7BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812989; c=relaxed/simple;
	bh=ISY1VHAkBH59Hhh3NWOdVMhtaP+U3MV4otA/Gltn4ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzBTjaMczEiu276zuf2wNmAcMOOPDboMX/KJ1YIhlF4xk9HIqvhJMw3MJRCcAY/FIMiiRUOdW1q9hdQ9ZohduKNLQUuF4aEnQQmgvQWANtdI3+0i2go/0NTemFy19/YMHoyGaXuzly7Bfsdttq1B0J33nMuuAN3cPg/R6onlQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3351B1042;
	Wed, 19 Jun 2024 09:03:31 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8EAA3F64C;
	Wed, 19 Jun 2024 09:03:05 -0700 (PDT)
Date: Wed, 19 Jun 2024 17:03:03 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-tip-commits@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/urgent] x86/resctrl: Don't try to free nonexistent
 RMIDs
Message-ID: <ZnMBN487xiPOfpRp@e133380.arm.com>
References: <20240618140152.83154-1-Dave.Martin@arm.com>
 <171879092443.10875.1695191697085701044.tip-bot2@tip-bot2>
 <ZnLUVtZ3oaFjcUj9@e133380.arm.com>
 <20240619134522.GCZnLg8pgJq9MPHS8M@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619134522.GCZnLg8pgJq9MPHS8M@fat_crate.local>

Hi Boris,

On Wed, Jun 19, 2024 at 03:45:22PM +0200, Borislav Petkov wrote:
> On Wed, Jun 19, 2024 at 01:51:34PM +0100, Dave Martin wrote:
> > This commit message now looks a mess on a regular terminal, since git
> > log indents the start of each line by four columns.
> 
> Well, we got rid of the 80 cols rule a long time ago so if you're looking at
> kernel code in that same terminal, you're looking at a similar mess?

<bikeshed>

It's still a guideline, no?  (Though I admit that common sense has to
apply and there are quite often good reasons to bust the limit in
code.)  But commit messages are not code, and don't suffer from
creeping indentation that eats up half of each line, so the rationale
is not really the same.

In block text, lines near maximum length are common, but when looking at
code OTOH, long lines are usually rare, so the file is not rendered
unreadable without linewrap turned off or a bigger terminal.

For git logs, git config core.pager 'less -S' makes things a little
better I suppose, since that at least keeps the left-hand columns blank
on the commit message lines, making the log easier to skim through by
eye.  There doesn't seem to be a way to bind a key to flip line
wrapping on and off in less at runtime, though I've not dug into it.

</bikeshed>


Anyway, I was just mildly surprised, it's not a huge deal.

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

(Quoted: "Text-based e-mail should not exceed 80 columns per line of
text.  Consult the documentation of your e-mail client to enable proper
line breaks around column 78.".  No statement about commit messages,
and "should not exceed" is not the same as "should be wrapped to".
This document doesn't seem to consider how git formats text derived
from emails.)

Cheers
---Dave

