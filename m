Return-Path: <linux-tip-commits+bounces-5999-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEB2AF8FE5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jul 2025 12:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE433BABCC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jul 2025 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E8A2EA48C;
	Fri,  4 Jul 2025 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="h0+Aa50G"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB38184;
	Fri,  4 Jul 2025 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624491; cv=none; b=Cbxknolp2GqrFBokliFapRdP668Dak7ZAP0RkV1SLljfhwwxqoLStP62k61dUxBCScyvITA1dqnjokYm80XFZ/aTA0iyKYNAEsTRuik9D4epKdbrW1rvnJsKWipVrL172pA6BjKrPY+o5xhgz8Qkkn5akDflWw7EcOjU8yAqrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624491; c=relaxed/simple;
	bh=+XTJSMqwvfGK5IaXH2uugAcTTaHPKMluCrXOEA+EqlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUowk8Q/uG7LyuhpPgpIWYGDjSl5lqR2nuSVBhZhbZ+UHETwz4z81CygCr8x0gS2t/+T4lHij1zeE+HnLjCrEW24JtB36seyNAFXQwDcI4bN6zkE51pcknM63pebW/GJKAzsm4x2BZuRwdjwg2dbrwDVT7ciqqMUO8P+6bHBpus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=h0+Aa50G; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7C05D40E021C;
	Fri,  4 Jul 2025 10:21:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SS55zBZ0gJcF; Fri,  4 Jul 2025 10:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751624477; bh=zuTBinfrd7r5RN2nXX6H17V7ulbklGFTT6rEOZ/+Ofw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h0+Aa50G1R9eOn6mk524xR/X6hJUJPvY8bFWADAqzL6b7jKxDv6DCcPiKdVYit6dJ
	 2JiBEzvFcKJlGtrS6p+8qWvx0HXVMysnrkDKkV7QS9J0fPc28AktTnlEZ05502alF6
	 zL1RurADea1G4ad4+duF6Bho8bMazk0m89ToaQJ8/jptWLqC23HkZbqZYhujDLGJxY
	 i+OvtKeqcAKAWo4bente4TYPlaOfCVYC9JPOqpVRh8FlPgxPUhbtZU+WDAMCkUHHC1
	 thqod0Sf1Z62W9poQJw/JNHk1GVMVDXd50PMc0p18Yc1rilssYyevBEuwjsHVbzBzl
	 zTiQJxxb4Ibhz6JyVeR1j7cIeYVTvWg5M1YNoQ8L2e9PEyxAn12fuo2rqSoxVjOklc
	 w9i8EH7spypr1Q/6/0t9LT7UHrbuqQ0MTwdfa1Q9/9Ev0RlEG+YGUaHzQK8wkRHOyl
	 2m76P7f42r8rJGw6D34hHyn42dAHwgBEkT1SKnA9ZFXOZn11PRzRL3Hau5OH3CysfJ
	 b3k5Q4sOJNz0TJBsJev6xjVg11hWHA69uVztOxlzhzGnIOiH0r+mjWh8r5DmTlZZ2r
	 xdZoaWZ7h0IPTm8dh/AaUEDB+KQB9O8Q2xj3qqZjw0eQbWflaFXGRRJ/6zrQK6m7j+
	 0WrRDO+pctdCsSFgpnpmLG1U=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 88F7A40E00DD;
	Fri,  4 Jul 2025 10:21:09 +0000 (UTC)
Date: Fri, 4 Jul 2025 12:21:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Subject: Re: [tip: sched/urgent] sched/fair: Use sched_domain_span() for
 topology_span_sane()
Message-ID: <20250704102103.GAaGerDxWX7VhePA3j@fat_crate.local>
References: <20250630061059.1547-1-kprateek.nayak@amd.com>
 <175162039637.406.8610358723761872462.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <175162039637.406.8610358723761872462.tip-bot2@tip-bot2>

On Fri, Jul 04, 2025 at 09:13:16AM -0000, tip-bot2 for K Prateek Nayak wrote:
> The following commit has been merged into the sched/urgent branch of tip:
> 
> Commit-ID:     02bb4259ca525efa39a2531cb630329fb87fc968
> Gitweb:        https://git.kernel.org/tip/02bb4259ca525efa39a2531cb630329fb87fc968
> Author:        K Prateek Nayak <kprateek.nayak@amd.com>
> AuthorDate:    Mon, 30 Jun 2025 06:10:59 
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 04 Jul 2025 10:35:56 +02:00
> 
> sched/fair: Use sched_domain_span() for topology_span_sane()

My guest doesn't like this one and reverting it ontop of the whole tip lineup
fixes it.

Holler for more data if needed.

[    0.280062] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.282922] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.287572] smp: Bringing up secondary CPUs ...
[    0.288623] smpboot: x86: Booting SMP configuration:
[    0.289085] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
[    0.302358] smp: Brought up 1 node, 16 CPUs
[    0.304445] smpboot: Total of 16 processors activated (118401.12 BogoMIPS)
[    0.307884] BUG: unable to handle page fault for address: 0000000089c402fb
[    0.307884] #PF: supervisor read access in kernel mode
[    0.307884] #PF: error_code(0x0000) - not-present page
[    0.307884] PGD 0 P4D 0 
[    0.307950] Oops: Oops: 0000 [#1] SMP NOPTI
[    0.308344] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-rc4+ #1 PREEMPT(full) 
[    0.309115] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2023.11-8 02/21/2024
[    0.309934] RIP: 0010:build_sched_domains+0x627/0x1550
[    0.310086] Code: 84 75 06 00 00 f3 48 0f bc c0 48 63 f8 89 c0 48 0f a3 05 c4 cf 95 08 0f 83 6c 06 00 00 48 8b 3c fd c0 db 29 82 49 8b 44 24 18 <48> 8b 04 07 48 8b 80 90 00 00 00 48 33 86 90 00 00 00 66 85 c0 0f
[    0.310086] RSP: 0018:ffffc9000001fe60 EFLAGS: 00010247
[    0.310086] RAX: ffffffff89c402f8 RBX: ffff88800cea8e40 RCX: 0000000000000001
[    0.310086] RDX: ffffffffffffffff RSI: ffff88800ceaacc0 RDI: 0000000100000003
[    0.310086] RBP: ffff88800cc4e3e0 R08: 0000000000000000 R09: 0000000000000000
[    0.310086] R10: 00000000fffedb1d R11: 00000000fffedb1d R12: ffff88800ceda4c0
[    0.310086] R13: ffff88800cea9500 R14: 0000000000000010 R15: 000000000000000f
[    0.310086] FS:  0000000000000000(0000) GS:ffff8880f39f2000(0000) knlGS:0000000000000000
[    0.310086] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.310086] CR2: 0000000089c402fb CR3: 0000000002c1a000 CR4: 00000000003506f0
[    0.310086] Call Trace:
[    0.310086]  <TASK>
[    0.310086]  ? sched_init_domains+0x58/0xa0
[    0.310086]  sched_init_smp+0x29/0x90
[    0.310086]  kernel_init_freeable+0xa3/0x290
[    0.310086]  ? __pfx_kernel_init+0x10/0x10
[    0.310086]  kernel_init+0x1a/0x1c0
[    0.310086]  ret_from_fork+0x85/0xf0
[    0.310086]  ? __pfx_kernel_init+0x10/0x10
[    0.310086]  ret_from_fork_asm+0x1a/0x30
[    0.310086]  </TASK>
[    0.310086] Modules linked in:
[    0.310086] CR2: 0000000089c402fb
[    0.310086] ---[ end trace 0000000000000000 ]---
[    0.310086] RIP: 0010:build_sched_domains+0x627/0x1550
[    0.310086] Code: 84 75 06 00 00 f3 48 0f bc c0 48 63 f8 89 c0 48 0f a3 05 c4 cf 95 08 0f 83 6c 06 00 00 48 8b 3c fd c0 db 29 82 49 8b 44 24 18 <48> 8b 04 07 48 8b 80 90 00 00 00 48 33 86 90 00 00 00 66 85 c0 0f
[    0.310086] RSP: 0018:ffffc9000001fe60 EFLAGS: 00010247
[    0.310086] RAX: ffffffff89c402f8 RBX: ffff88800cea8e40 RCX: 0000000000000001
[    0.310086] RDX: ffffffffffffffff RSI: ffff88800ceaacc0 RDI: 0000000100000003
[    0.310086] RBP: ffff88800cc4e3e0 R08: 0000000000000000 R09: 0000000000000000
[    0.310086] R10: 00000000fffedb1d R11: 00000000fffedb1d R12: ffff88800ceda4c0
[    0.310086] R13: ffff88800cea9500 R14: 0000000000000010 R15: 000000000000000f
[    0.310086] FS:  0000000000000000(0000) GS:ffff8880f39f2000(0000) knlGS:0000000000000000
[    0.310086] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.310086] CR2: 0000000089c402fb CR3: 0000000002c1a000 CR4: 00000000003506f0
[    0.310086] note: swapper/0[1] exited with irqs disabled
[    0.310091] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    0.311130] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

