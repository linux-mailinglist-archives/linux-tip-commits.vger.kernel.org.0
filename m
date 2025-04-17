Return-Path: <linux-tip-commits+bounces-5045-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0233BA91F54
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 16:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8163B125A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 14:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6531F1B4153;
	Thu, 17 Apr 2025 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="I3yzOqP9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38DF9EC;
	Thu, 17 Apr 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899499; cv=none; b=u+nOuFQZJbBRxLdJ19evrFptjRGqw+IuhgJjIAM8raYKJtV2+9k6x6aFXyFqQT5qCkJU1bChOAinGrovUZW2BLdIRfBNBhkCSnnI+MwUSJevt1ePRgC7L/K5J9mz2PgO2kXtC96KImoIgiXGYm9oIH5Gux17ComAFGWpcQ3leAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899499; c=relaxed/simple;
	bh=ogbzXbPaaVrpysAm9GDN/zeNCLSQ6+n6Y7bEzCdmPdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtTtVknJq6ciDdvXgq0cECCMRymBoZu89xl5U+pXMMxzS+dcZE01jl5FWj6MVuIiv7n/yJZKueZ/OSXv5coQinWQqxf215Z2uLlLyZCBRTm/UHXcKsZu3bPLgAE+CYJc6A2DNK86f5mwbYNBjUAk+FGVbJhCV9QMxki43hhWmCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=I3yzOqP9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D39E240E0248;
	Thu, 17 Apr 2025 14:18:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HA1r3aB_pVnO; Thu, 17 Apr 2025 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744899488; bh=7eQQq1DJrnX54xIua4pvbzUmNo6euVrOC12zQEBYgBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3yzOqP9Ki+vlZMXLDagdHXcIu7JS54Hss2AtiMSZE4c6q0dGvlIa/5qQtWXA2aOd
	 bd3xzVm2kP5vhbhTSQLSb5Ngg36HGCFKGysM/lnosfN9dXuq28ctoXOy92fy45cm+P
	 PopRH7jDZBJ7iXtfcO4iYItsgpnjQCOcNC15Nuh2B7P/M1FLCv8Z6lYRWAmNV0tp6N
	 qJM3rUT/DFHXzW0djy4wpVn4e5IZQeOvhdtxSC8BE2zUqdLESlsaq6kS2/SvTHg2LN
	 vChcaHCWzmVo0cCXc6kGIGAh5XBLF6FroRGhzk8I2DOE7PHmZfJCmq/J1Ssv1/AL0+
	 JBO4KfdMZduLeAOpezt2KpS3PvkPfRf3F+VBlsiJHsQAvtPGDhiyqk4h4gJZpCAf/X
	 TB2d43v27ejJ3kw6YBpfwrBfiuIm/bHZdqOxjzUBEur2rHiEYdtrLScSQhVgqNyZ/H
	 rRH6qm2Rl0PLfAPo2zRP+CraenwGQR6UjU5ZZelixHYDs7dYyWZ6fU/lxDPzHfqf8G
	 p00yo10/anSMFPHHO3FX9oQZvF0uVA7Qsxqip+ndHF4D1tsJ/OXMPicOFM1o71ECKt
	 sZ/2qAxoD16OK0+Vd3Pit6iZqwroK5r9vOIYY4HxFhEAxqRFgW4ZXCgczCGma3EE3S
	 UUtcXHvadTYm/1SPx7RSujWo=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D190840E01FF;
	Thu, 17 Apr 2025 14:17:57 +0000 (UTC)
Date: Thu, 17 Apr 2025 16:17:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/alternatives] x86/efi: Make efi_enter/leave_mm() use
 the use_/unuse_temporary_mm() machinery
Message-ID: <20250417141751.GAaAENj1RsBOtp2Tvb@fat_crate.local>
References: <20250402094540.3586683-7-mingo@kernel.org>
 <174448360887.31282.4227052210506129936.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174448360887.31282.4227052210506129936.tip-bot2@tip-bot2>

On Sat, Apr 12, 2025 at 06:46:48PM -0000, tip-bot2 for Andy Lutomirski wrote:
> The following commit has been merged into the x86/alternatives branch of tip:
> 
> Commit-ID:     e7021e2fe0b4335523d3f6e2221000bdfc633b62
> Gitweb:        https://git.kernel.org/tip/e7021e2fe0b4335523d3f6e2221000bdfc633b62
> Author:        Andy Lutomirski <luto@kernel.org>
> AuthorDate:    Wed, 02 Apr 2025 11:45:39 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Sat, 12 Apr 2025 10:06:04 +02:00
> 
> x86/efi: Make efi_enter/leave_mm() use the use_/unuse_temporary_mm() machinery
> 
> This should be considerably more robust.  It's also necessary for optimized
> for_each_possible_lazymm_cpu() on x86 -- without this patch, EFI calls in
> lazy context would remove the lazy mm from mm_cpumask().
> 
> [ mingo: Merged it on top of x86/alternatives ]
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Link: https://lore.kernel.org/r/20250402094540.3586683-7-mingo@kernel.org
> ---
>  arch/x86/platform/efi/efi_64.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index ac57259..a5d3496 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -434,15 +434,12 @@ void __init efi_dump_pagetable(void)
>   */
>  static void efi_enter_mm(void)
>  {
> -	efi_prev_mm = current->active_mm;
> -	current->active_mm = &efi_mm;
> -	switch_mm(efi_prev_mm, &efi_mm, NULL);
> +	efi_prev_mm = use_temporary_mm(&efi_mm);
>  }
>  
>  static void efi_leave_mm(void)
>  {
> -	current->active_mm = efi_prev_mm;
> -	switch_mm(&efi_mm, efi_prev_mm, NULL);
> +	unuse_temporary_mm(efi_prev_mm);
>  }
>  
>  void arch_efi_call_virt_setup(void)

mingo thinks this one causes this:

[    0.119491] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.119498] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.137368] Freeing SMP alternatives memory: 40K
[    0.137381] pid_max: default: 32768 minimum: 301
[    0.137496] ------------[ cut here ]------------
[    0.137502] WARNING: CPU: 0 PID: 0 at arch/x86/mm/tlb.c:795 switch_mm_irqs_off+0x3d3/0x460
[    0.137516] Modules linked in:
[    0.137526] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0-rc2+ #3 PREEMPT(voluntary) 
[    0.137537] Hardware name: HP HP ProBook 635 Aero G7 Notebook PC/8830, BIOS S84 Ver. 01.05.00 05/14/2021
[    0.137548] RIP: 0010:switch_mm_irqs_off+0x3d3/0x460
[    0.137556] Code: 28 00 65 ff 0d 3e c9 db 01 0f 85 88 fd ff ff 0f 1f 44 00 00 e9 7e fd ff ff be 00 01 00 00 31 ff e8 02 cb fb ff e9 be fd ff ff <0f> 0b e9 6c fc ff ff 9c 58 f6 c4 02 0f 84 c4 fd ff ff e8 46 3b 59
[    0.137575] RSP: 0000:ffffffffb6a03e00 EFLAGS: 00010202
[    0.137583] RAX: 0000000000000246 RBX: ffffffffb6c5fd40 RCX: 0000000100238000
[    0.137591] RDX: ffffffffb6a149c0 RSI: ffffffffb6c5fd40 RDI: 0000000000000000
[    0.137599] RBP: ffffffffb6bbcdc0 R08: 00000000b357d000 R09: 0000000000000000
[    0.137607] R10: 000000010ab06067 R11: 0000000000000000 R12: ffffffffb6a149c0
[    0.137616] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.137624] FS:  0000000000000000(0000) GS:ffff9b6093385000(0000) knlGS:0000000000000000
[    0.137633] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.137640] CR2: ffff9b6048601000 CR3: 0000000106c26000 CR4: 0000000000350ef0
[    0.137648] Call Trace:
[    0.137653]  <TASK>
[    0.137658]  use_temporary_mm+0x55/0x90
[    0.137666]  efi_set_virtual_address_map+0xfd/0x1b0
[    0.137676]  efi_enter_virtual_mode+0x3e3/0x450
[    0.137685]  start_kernel+0x6b7/0x720
[    0.137693]  x86_64_start_reservations+0x24/0x30
[    0.137700]  x86_64_start_kernel+0x7a/0x80
[    0.137706]  common_startup_64+0x13e/0x141
[    0.137717]  </TASK>
[    0.137720] irq event stamp: 128439
[    0.137725] hardirqs last  enabled at (128447): [<ffffffffb579dcd2>] __up_console_sem+0x52/0x60
[    0.137737] hardirqs last disabled at (128454): [<ffffffffb579dcb7>] __up_console_sem+0x37/0x60
[    0.137748] softirqs last  enabled at (105766): [<ffffffffb56f57b6>] __irq_exit_rcu+0x96/0xc0
[    0.137759] softirqs last disabled at (105759): [<ffffffffb56f57b6>] __irq_exit_rcu+0x96/0xc0
[    0.137770] ---[ end trace 0000000000000000 ]---
[    0.137777] ------------[ cut here ]------------
[    0.137782] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/cpu/common.c:453 cr4_update_irqsoff+0x45/0x70
[    0.137794] Modules linked in:
[    0.137800] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W           6.15.0-rc2+ #3 PREEMPT(voluntary) 
[    0.137813] Tainted: [W]=WARN
[    0.137817] Hardware name: HP HP ProBook 635 Aero G7 Notebook PC/8830, BIOS S84 Ver. 01.05.00 05/14/2021
[    0.137827] RIP: 0010:cr4_update_irqsoff+0x45/0x70
[    0.137834] Code: 0b 65 8b 0d d5 3d e0 01 85 c9 74 13 48 f7 d7 48 21 d7 48 09 c7 48 39 fa 75 20 e9 f6 8d b8 00 65 8b 0d 9b 3a e0 01 85 c9 74 e2 <0f> 0b 48 f7 d7 48 21 d7 48 09 c7 48 39 fa 74 e0 65 48 89 3d eb 6a
[    0.137853] RSP: 0000:ffffffffb6a03df8 EFLAGS: 00010202
[    0.137860] RAX: 0000000000000000 RBX: ffffffffb6c5fd40 RCX: 0000000000000001
[    0.137868] RDX: 0000000000350ef0 RSI: 0000000000000100 RDI: 0000000000000100
[    0.137876] RBP: ffffffffb6bbcdc0 R08: 00000000b357d000 R09: 0000000000000000
[    0.137884] R10: 000000010ab06067 R11: 0000000000000000 R12: 000000010022e000
[    0.137892] R13: 0000000000010000 R14: 0000000000000000 R15: 0000000000000000
[    0.137900] FS:  0000000000000000(0000) GS:ffff9b6093385000(0000) knlGS:0000000000000000
[    0.137909] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.137916] CR2: ffff9b6048601000 CR3: 000000010022e000 CR4: 0000000000350ef0
[    0.137924] Call Trace:
[    0.137928]  <TASK>
[    0.137932]  switch_mm_irqs_off+0x3ce/0x460
[    0.137940]  use_temporary_mm+0x55/0x90
[    0.137946]  efi_set_virtual_address_map+0xfd/0x1b0
[    0.137956]  efi_enter_virtual_mode+0x3e3/0x450
[    0.137964]  start_kernel+0x6b7/0x720
[    0.137971]  x86_64_start_reservations+0x24/0x30
[    0.137978]  x86_64_start_kernel+0x7a/0x80
[    0.137984]  common_startup_64+0x13e/0x141
[    0.137994]  </TASK>
[    0.137998] irq event stamp: 128723
[    0.138002] hardirqs last  enabled at (128731): [<ffffffffb579dcd2>] __up_console_sem+0x52/0x60
[    0.138013] hardirqs last disabled at (128738): [<ffffffffb579dcb7>] __up_console_sem+0x37/0x60
[    0.138024] softirqs last  enabled at (105766): [<ffffffffb56f57b6>] __irq_exit_rcu+0x96/0xc0
[    0.138034] softirqs last disabled at (105759): [<ffffffffb56f57b6>] __irq_exit_rcu+0x96/0xc0
[    0.138045] ---[ end trace 0000000000000000 ]---


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

