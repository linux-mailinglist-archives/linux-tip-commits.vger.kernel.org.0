Return-Path: <linux-tip-commits+bounces-7960-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CE8D19DE9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEBFF30042B0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B9A363C64;
	Tue, 13 Jan 2026 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1O0UYT8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC3630171A;
	Tue, 13 Jan 2026 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317997; cv=none; b=VmJgcuGXLVzIOHwbBkdvqywm6YWZgLX+wpzHqc3wiyuH9yyRVbNWhv/EFJ25NbkN1S9+8azst10C5J+wJTLcrZftTotuqns4VYCGdg9VClTTQMHabYR4gxywztP4mpf0tVCFgalfUica7Rk09AiSHS9vZSTAc3efKNtIDjNDddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317997; c=relaxed/simple;
	bh=rAOFp+Lw9PRBllXmPyh/0uSQG2O6gtprXGgLkKmaOE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=giy5+7uqayoFXV7lVrB+ZoljNysDcGVfUZNuddhY5LRXa80IBO9ESbySDnofb14Q+lpvmkSbRr7RNFcQViFKxgrx/RQxShF0WvXOlNkML3KrareXneKRFSTY97zkGvrRKBfPrq1ul8t3VZeX3cgCTH1miydipSycaHkRgDBOLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1O0UYT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004D8C116C6;
	Tue, 13 Jan 2026 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768317996;
	bh=rAOFp+Lw9PRBllXmPyh/0uSQG2O6gtprXGgLkKmaOE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L1O0UYT8WmONn0fL8z0VbgVIdusdGVNwZkvfV45TOTKhSuJHTXSiVopRb5MslL4sG
	 vbNYV0d+nmNu5EhuEHXQBlkGlK4lDUhUhgKMdP+NFk+2Q6AS04mKlU822aAJRU0/fl
	 5XR2jusidDfBFRCAFTHdNoOuDo78frK5FDjGSB2Lva7/efe4htzlvHbRrMYz1I3EGA
	 6ZO+bk7eNsqBiUYFi3t3X4Wrp9ovk/NxWTb+IQIiv6ccHcD1dMpuEAZPOSVxalsTpq
	 CZLaFn3H9nOlf9AwHJn667+08OhnGzbah6ymZ+WUOhFG/MK8CqkIYSOICQ5CUIEzID
	 EvTcNjyTKN/nQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, x86@kernel.org, maz@kernel.org
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
In-Reply-To: <20260113120541.YVf2vRA3@linutronix.de>
References: <20260112134013.eQWyReHR@linutronix.de>
 <176829473742.510.5940174319056100768.tip-bot2@tip-bot2>
 <20260113120541.YVf2vRA3@linutronix.de>
Date: Tue, 13 Jan 2026 16:26:33 +0100
Message-ID: <87ecntjzyu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 13 2026 at 13:05, Sebastian Andrzej Siewior wrote:
> On 2026-01-13 08:58:56 [-0000], tip-bot2 for Sebastian Andrzej Siewior wrote:
>> The following commit has been merged into the irq/core branch of tip:
>> 
>> Commit-ID:     aef30c8d569c0f31715447525640044c74feb26f
>> Gitweb:        https://git.kernel.org/tip/aef30c8d569c0f31715447525640044c74feb26f
>> Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> AuthorDate:    Mon, 12 Jan 2026 14:40:13 +01:00
>> Committer:     Thomas Gleixner <tglx@kernel.org>
>> CommitterDate: Tue, 13 Jan 2026 09:56:25 +01:00
>> 
>> genirq: Warn about using IRQF_ONESHOT without a threaded handler
>
> Should I pro-active send some patches to those users which I know do it
> wrong? Or do we simply wait?

Just send fixes for them ...

