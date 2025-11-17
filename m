Return-Path: <linux-tip-commits+bounces-7382-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCC7C65E50
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 20:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BB2C362095
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 19:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C8A304BA0;
	Mon, 17 Nov 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jHlK6wNl"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9081C2877D7;
	Mon, 17 Nov 2025 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406429; cv=none; b=SYxSxnrAvUsDIytUn7nc7hfwsurOyBIp0DLidLLTzqIBo2c3ZUiSgkqUIvf7sWMhMpzS8N2YuzQM6LNVyjVlQZMdzlccskTRNw0U0CM+WKK1x6MkO3toUMOChtSevc87lyecAxqp/Zvk0DfbMYmHXMF1+HMaQ5JRCbVntQISDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406429; c=relaxed/simple;
	bh=gH7ybJKYpzcIHZjQ0uJaRw0f1Zni17lhxNfHxhmw+/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9LvngH7ui0N5ZbHldZbHyPHYw+VRrojdY2S+LPRuAe+DqbEq1fOkyJWWTf0I3Sa6WwZUY8tVTU+vvGYHB4DvQFmFTwTLiX3EhIGGv7wTBChLS73tTCv3iqTPcneLOELK9s8YmsNuiiuFIeYjZxhubtaHt05Y2tRboB6g6V9Q4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jHlK6wNl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0FF5540E0216;
	Mon, 17 Nov 2025 19:07:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rfXEmGTTnpZS; Mon, 17 Nov 2025 19:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763406419; bh=N4PH0C92flXoR5l8LWtwhoNGoAb0kV+3/PqOXvmrUGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHlK6wNl+ghF7N94m3g8DQKgy+SD5mQLeV1dtQvGFZG+MB78UQW012xiElnWofuVm
	 atmZnY0S+CrhTC1sdWydQ9WZU6kYEBFE1tETSJ5ibNp0/Ry2kMPjtsaHxMrbp0f1KV
	 Ql0jHyqiIw4Pos2zV7pC05Z+I1Bly3WrZrWYxXx6hys3Dg0GhIvqi4dGOq3URIpNmg
	 rzcW4sFICZazk1MBd4gn1ZUuePSeqodo0B21RsxEo/WZtpn4DT4Rt3fMdw/pbSAHPa
	 2uJvKnDwxbGKBpnH59t+ArmVybgI3RgkNDCA1/U5d9zA8PGOKzhcpjQX5xprv9eU2L
	 fIXyWDsXb5wWe28D7hTvL4OeceObIhPuqFO/YvbGXxNKduoMLiPUmRvpDpFI6YNk9h
	 dAIrYJrApNcpLcjc1icN3GZPH6LDO6AB1LS/t07qWOHAHSXEVSkyuDtgncR/ktd2Z3
	 Dhbn8d+YNLYkqxbvZ39mXPeQo4heR3syRS+t6jFaHjQGnt0pM6RPchJk3Ug97AnIFF
	 +3RKjgnViGxajYBn9XIuJ+JhKmTs4N2bEb3rREkfrjuqM+8USp8Uo0+eKU/PD0m4H+
	 lZ4byyzDnKSbilnwkw5z4Vsep8t1nPQu7odwl02q1pVvvuTgMq/IwCEYxGFTQ7Unr/
	 yN9xIF3NEgF+a5KNoa4kIe2o=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 64D4640E022F;
	Mon, 17 Nov 2025 19:06:48 +0000 (UTC)
Date: Mon, 17 Nov 2025 20:06:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
	linux-tip-commits@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
Message-ID: <20251117190641.GCaRtyQXdOhKrlAF7Y@fat_crate.local>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <176312274812.498.6548506845675120622.tip-bot2@tip-bot2>
 <dffe53a4-0ef2-4346-ad73-c4b71a734b3a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dffe53a4-0ef2-4346-ad73-c4b71a734b3a@linux.ibm.com>

On Sun, Nov 16, 2025 at 02:26:13AM +0530, Shrikanth Hegde wrote:
> 
> Hi Peter.
> 
> On 11/14/25 5:49 PM, tip-bot2 for Tim Chen wrote:
> > The following commit has been merged into the sched/core branch of tip:
> > 
> > Commit-ID:     2265c5d4deeff3bfe4580d9ffe718fd80a414cac
> > Gitweb:        https://git.kernel.org/tip/2265c5d4deeff3bfe4580d9ffe718fd80a414cac
> > Author:        Tim Chen <tim.c.chen@linux.intel.com>
> > AuthorDate:    Mon, 10 Nov 2025 10:47:35 -08:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Fri, 14 Nov 2025 13:03:05 +01:00
> > 
> > sched/fair: Skip sched_balance_running cmpxchg when balance is not due
> > 
> > 
> 
> > +	if (!need_unlock && (sd->flags & SD_SERIALIZE) && idle != CPU_NEWLY_IDLE) {
> > +		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
> 
> This should be atomic_cmpxchg_acquire?
> 
> I booted the system with latest sched/core and it crashes at the boot.
> 
> BUG: Kernel NULL pointer dereference on read at 0x00000000
> Faulting instruction address: 0xc0000000001db57c
> Oops: Kernel access of bad area, sig: 7 [#1]
> LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> Modules linked in:
> CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.18.0-rc3+ #242 PREEMPT(lazy)
> NIP [c0000000001db57c] sched_balance_rq+0x560/0x92c
> LR [c0000000001db198] sched_balance_rq+0x17c/0x92c
> Call Trace:
> [c00000111ffdfd10] [c0000000001db198] sched_balance_rq+0x17c/0x92c (unreliable)
> [c00000111ffdfe50] [c0000000001dc598] sched_balance_domains+0x2c4/0x3d0
> [c00000111ffdff00] [c000000000168958] handle_softirqs+0x138/0x414
> [c00000111ffdffe0] [c000000000017d80] do_softirq_own_stack+0x3c/0x50
> [c000000008a57a60] [c000000000168048] __irq_exit_rcu+0x18c/0x1b4
> [c000000008a57a90] [c0000000001691a8] irq_exit+0x20/0x38
> [c000000008a57ab0] [c000000000028c18] timer_interrupt+0x174/0x394
> [c000000008a57b10] [c000000000009f8c] decrementer_common_virt+0x28c/0x290
> 
> 
> Bisect pointed to:
> git bisect bad 2265c5d4deeff3bfe4580d9ffe718fd80a414cac
> # first bad commit: [2265c5d4deeff3bfe4580d9ffe718fd80a414cac] sched/fair: Skip sched_balance_running cmpxchg when balance is not due

Dammit, I spent a whole day bisecting exactly the same issue and I missed your
mail.

Oh well, it is fixed now... should pay more attention next time.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

