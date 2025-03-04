Return-Path: <linux-tip-commits+bounces-3949-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CC7A4EAC7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB5842294F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 18:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F8D2BD5BF;
	Tue,  4 Mar 2025 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cATQX4SO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32844284B5B;
	Tue,  4 Mar 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110359; cv=none; b=KKIdRyEBSBTWc3ARidxcqQW8yo/oPQ+NHyamXXgGOspcZWZrU+DKjPQae9+W5OHvJWghxmU4lGeuAxOvNzR2QBvbAeEYjQCMj2X6C37QwaLurb1o5cqCQYZohX0uWqitylFjXmwSOoOBmxb37l7qD0UzQFKDWXWEqSiZ2IG2NfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110359; c=relaxed/simple;
	bh=rC/oo/enE7GE0ijiRwfs0hAzlQSt3YHvjCTih3uUFwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EK0IGOA2GhTZ/R2EUuuNyjscHN8mG+6mxKw7P30Qitq2W5hpcKGcCCSHC1oFI5DwOgHKiidx0AG5mrAFXHXTMsGKgj0NFF8RQYKnZi9mis8LZTLyClTjHUiaXNbubfpvRDIwMy7TlJRE+LqTFOlmvkoMWPbnGvt2dz9Pz8K/64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cATQX4SO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AF4C4CEE5;
	Tue,  4 Mar 2025 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741110358;
	bh=rC/oo/enE7GE0ijiRwfs0hAzlQSt3YHvjCTih3uUFwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cATQX4SO8pIuv2V3ErkAAOjCLrDPUufE6F4qrkpKtI2/quE8YGHDDznBu8/G5peZM
	 Pm9LcVxM0NEzmH/VOZ95/WcrPsCPDmr5SNzUSCJw1b57GmjLZ2gz9jI4gGs7qmPZ0w
	 mME/vRd9Hiqp02j50OpdUY2ecwJKL/wSnFM5BaVVS6YPk6pv/f7fUJ0wIkjVume/n4
	 pNW9nzQcaAXJpC9I+/scxw4+8plBgnPTycUC9oooFZYe6H8cxLcH3oFI4W4W/mF+u2
	 85bl3SF/MoSAj+f01rmffn7MLEOz1aET7xqky2Q6jBS2ZJdi4oEhVDU/JMVhHd0MHb
	 TxAgCpCcmAd/A==
Date: Tue, 4 Mar 2025 09:45:56 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, brgerst@gmail.com,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	mingo@kernel.org, peterz@infradead.org, tip-bot2@linutronix.de,
	torvalds@linux-foundation.org, x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250304174556.hva7f2p4uchhh5dd@jpoimboe>
References: <28D821BB-96B5-4389-839E-5B7CB4D49F5F@zytor.com>
 <c7496069-2630-45ca-b6d3-c8d6b3678271@citrix.com>
 <82FF5D6C-15F5-44FE-8436-CDBB9F35FDD5@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82FF5D6C-15F5-44FE-8436-CDBB9F35FDD5@zytor.com>

On Mon, Mar 03, 2025 at 06:05:07PM -0800, H. Peter Anvin wrote:
> On March 3, 2025 4:57:49 PM PST, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> >> One more thing: if we remove ASM_CALL_CONSTRAINTS, we will not be able to use the redzone in future FRED only kernel builds.
> >
> >That's easy enough to fix with "|| CONFIG_FRED_EXCLUSIVE" in some
> >theoretical future when it's a feasible config to use.
> >
> >~Andrew
> 
> Assuming it hasn't bitrotted...

If we start using red zone, I'm thinking it should be fairly easy to add
"red zone stack validation" to objtool.  Then the build bots should be
able to shake out pretty quickly where ASM_CALL_CONSTRAINT is needed.

-- 
Josh

