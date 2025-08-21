Return-Path: <linux-tip-commits+bounces-6307-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE073B3013F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Aug 2025 19:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70B6171922
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Aug 2025 17:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0D92E2F16;
	Thu, 21 Aug 2025 17:39:55 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C122EC546;
	Thu, 21 Aug 2025 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797995; cv=none; b=UHMIX192m0teUGnhzwfSK3JtWJ2aqF2s/2aLFn0ruJKVTdTlkX2CDQ4PRx02t/YS8D2z1mi4epiVmmPVo8omxTsCZETC6k/3CQi0gJCtrEgdZk/261BgFVNTiEjaWHVixVdsqKUr5tki1Jp+eePfDEeklKStBrj63LqZZ1WSSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797995; c=relaxed/simple;
	bh=vHNVIm9D6XoW/C3oPkqvwbV6YX8u1xXVJ82mGfqLVeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIjJD+cscJM7fNrClsiOPjrM2dT3zOOHN+kjZ/9aWqOSTlnApvnVGqYNKV+mMyXkq2/Efs6P6j2jAG0ZriKjz/loFP9qHsxtK5VS24SlUrJKDXJp7SFB7GjvULJHurFhIpJ7+9SPyC3nCNgp1AT2mSXteOMF5BreXzCxihFLOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb73394b4so189750966b.0;
        Thu, 21 Aug 2025 10:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755797992; x=1756402792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWCRehxUi3dcqmvopLglozV1gP1eEqXlVldqJJREc28=;
        b=KjAm1paC93Bu8CeWkqrgW4RXW2UT4VH+6/cxo00KZP1otQpUvN/hS0JRqfjl682uP1
         LrZr7BQRNW60t97WmRsLFtZvcudRmMnEadB2h5KCamzulSCLnHJh718o3mh5B3fz0TKf
         vQlpSV1VeZ1sS/7RPku8ELhsUeayCjao5uW3P/fUvRiBkl7fAMbeQaRzNVTHZ/WXfmb7
         btfUyv9s//UgHaGXiXA0t+dvQcA44VsNbnFG5ViXap7womEI8MnH3iey1LcqCKNaCGWr
         M676wNN0tqulLFVZY64h2pPK9F3xk4slU5Lv5eGPrTfAoN6s6dU8AcqJjfeYW7lrvNRI
         Q1/g==
X-Forwarded-Encrypted: i=1; AJvYcCWF+rwNSfL4zcUTPLRIWcq+IBobuNfujf4toVyIFXgyfO+8/jkj+U8t4qkwJwaQO6NRB7Sc7lb9cRO4wwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs54YMu/uOiizHslde1MgQHYjOqbLyyyfIa3VQS+2/SqSdRJVg
	YTj+4/n9FMUFS+v3Nncac8+8hLfNSEW+uKfnNGf6rv92wGPDIPgBwzWd
X-Gm-Gg: ASbGnctVixGqdYHrNIJG8dtv6EB4GWC+PtfI0Sc/HCBHkjR1wZ9G1vdZ8bhnuuDYDyv
	bHj5HIGbH4Ty1iCEQz8MAJK28ODJjmn0Lunk7UxE1S93DFj23gBMuzKa0xyCrSX+P0aTQ+aJnk5
	5Ttly96Dabwy4aKcPuev0CBIqw/caxBtJvCSENh/K82vMAz1rcT0YsuVpV5Uu+58zJ1L75+Rueq
	8uz75PGnh9Dpc2nTz4RdV40Zb7LPz+uGmFBrRwD8W1TqOrRduHZ8Vc0VfBzafxTkOr84cJqPR04
	pC+sqH8FaeDoEP1b3s7zHbhfKvSSx872JzyX2OOwK2P4zr7FGhw3tKynNLhL7zHVRNLZOIC4C+J
	wBccYHvmZY4dgdI/llDw3v9CUNvGrJHKJuA==
X-Google-Smtp-Source: AGHT+IGrBDrmFLswwYd0VLsXPltUiqsntmSJypnq50lQUaLd1sI0UTGf9D/NTIUdWNheuyNJOYku3w==
X-Received: by 2002:a17:907:940d:b0:ae3:a78d:a08a with SMTP id a640c23a62f3a-afe28ec4312mr1541366b.6.1755797992246;
        Thu, 21 Aug 2025 10:39:52 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2bc305sm421775766b.18.2025.08.21.10.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 10:39:51 -0700 (PDT)
Date: Thu, 21 Aug 2025 10:39:49 -0700
From: Breno Leitao <leitao@debian.org>
To: tglx@linutronix.de
Cc: linux-tip-commits@vger.kernel.org, andre.draszik@linaro.org, 
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: locking/urgent] futex: Move futex cleanup to __mmdrop()
Message-ID: <2bj2ncq7bkgmbmfi2fqwdv3w5adufivi73dzvfewn24yfn4eaa@ahftyvf6ff6z>
References: <87ldo5ihu0.ffs@tglx>
 <175414093081.1420.8088049602488588887.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175414093081.1420.8088049602488588887.tip-bot2@tip-bot2>

On Sat, Aug 02, 2025 at 01:22:10PM +0000, tip-bot2 for Thomas Gleixner wrote:
> The following commit has been merged into the locking/urgent branch of tip:
> 
> Commit-ID:     e703b7e247503b8bf87b62c02a4392749b09eca8
> Gitweb:        https://git.kernel.org/tip/e703b7e247503b8bf87b62c02a4392749b09eca8
> Author:        Thomas Gleixner <tglx@linutronix.de>
> AuthorDate:    Wed, 30 Jul 2025 21:44:55 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Sat, 02 Aug 2025 15:11:52 +02:00
> 
> futex: Move futex cleanup to __mmdrop()
> 
> Futex hash allocations are done in mm_init() and the cleanup happens in
> __mmput(). That works most of the time, but there are mm instances which
> are instantiated via mm_alloc() and freed via mmdrop(), which causes the
> futex hash to be leaked.
> 
> Move the cleanup to __mmdrop().
> 
> Fixes: 56180dd20c19 ("futex: Use RCU-based per-CPU reference counting instead of rcuref_t")
> Reported-by: André Draszik <andre.draszik@linaro.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: André Draszik <andre.draszik@linaro.org>
> Link: https://lore.kernel.org/all/87ldo5ihu0.ffs@tglx
> Closes: https://lore.kernel.org/all/0c8cc83bb73abf080faf584f319008b67d0931db.camel@linaro.org

Thomas,

it seems this change caused the bug being reported here:

https://lore.kernel.org/all/20250818131902.5039-1-hdanton@sina.com/

