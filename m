Return-Path: <linux-tip-commits+bounces-1468-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F890EB77
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 14:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A372B1F24424
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 12:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8383143873;
	Wed, 19 Jun 2024 12:51:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA93FC1F;
	Wed, 19 Jun 2024 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801504; cv=none; b=nFlwXukDzYcfO6F243Q6ujo6F2kytmfwlgRaowzX003kKMIdDIbBo0SlChk2UcuTFBkyjLPmPSSCwLfEb81OuKqZcGxG9Jnk0/+kzAuMTOfSMb8YGznX0OIY7vh4XG7fIKYxudMKxlU47IzuYZg6JOfTBx8xfCj/MLFVZ1QVNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801504; c=relaxed/simple;
	bh=fZhA7wMdEuBTl4TsjxP/TUlveOkHj0aHEqH7PngOP4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOwql+a2JlIyA1kzDQHhrDR6pW2VChRt7fwmJkWe1+DGrjFVeeI0+n2potgw1kw5yiwUp0zsA/hWKLWYxdAuXg7wK0qQumw+4Qxal37jKwLNQufeS3HHPPJDa3EH6q2LEl72jckRrCCbxGUCVdptBH3gJ+AEDDQbFzf7O8PZvZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 121931042;
	Wed, 19 Jun 2024 05:52:06 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 993AA3F6A8;
	Wed, 19 Jun 2024 05:51:40 -0700 (PDT)
Date: Wed, 19 Jun 2024 13:51:34 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: linux-tip-commits@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/urgent] x86/resctrl: Don't try to free nonexistent
 RMIDs
Message-ID: <ZnLUVtZ3oaFjcUj9@e133380.arm.com>
References: <20240618140152.83154-1-Dave.Martin@arm.com>
 <171879092443.10875.1695191697085701044.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171879092443.10875.1695191697085701044.tip-bot2@tip-bot2>

On Wed, Jun 19, 2024 at 09:55:24AM -0000, tip-bot2 for Dave Martin wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     739c9765793e5794578a64aab293c58607f1826a
> Gitweb:        https://git.kernel.org/tip/739c9765793e5794578a64aab293c58607f1826a
> Author:        Dave Martin <Dave.Martin@arm.com>
> AuthorDate:    Tue, 18 Jun 2024 15:01:52 +01:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Wed, 19 Jun 2024 11:39:09 +02:00
> 
> x86/resctrl: Don't try to free nonexistent RMIDs
> 
> Commit
> 
>   6791e0ea3071 ("x86/resctrl: Access per-rmid structures by index")
> 
> adds logic to map individual monitoring groups into a global index space used
> for tracking allocated RMIDs.

[...]

>   [ bp: Massage commit message. ]

Thanks Boris for picking this up.

Is there a preferred line length for commit messages in tip?  I don't
see anything in maintainer-tip.rst about this.

This commit message now looks a mess on a regular terminal, since git
log indents the start of each line by four columns.

Maintainer's choice, I guess, but just in case this effect is not
intentional I thought I ought to draw attention to it.

Cheers
---Dave

