Return-Path: <linux-tip-commits+bounces-5205-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DA5AA8091
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 May 2025 14:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A339A1B21
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 May 2025 12:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060241F1510;
	Sat,  3 May 2025 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NtK7Ho7X"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C7182;
	Sat,  3 May 2025 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746274066; cv=none; b=Ti/WO3QxZRvtZpO7RDZsnJIOcdK4BWFjCgyrPwkN4Yg6mhoPpibTMwCISNtdSRquC78llMNk7weoOFACIu9Uh6nqo01qvIqa8etShRKDPZD5VJGeDKZCk+9Cy73Yld7QJlfW3vaLJlIJPGn4FpUqy5Q8dTy8y+NNT/pZnlj1isQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746274066; c=relaxed/simple;
	bh=xURoyVohLnXtIHjBFLS8HV022V4nATDEUMvGaKCIqSg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ahYt5aAKtf9+2/qRBPVyXcXsCPhCF4X6g4eqgkfdi0mvwUoZr5MrABVWkNY9oyX8DsJayIrALvTlwa5NSpaGEsBwbajiaqcSDvf8DynHHQTwNttrGfLscFAblsLMD9C8Ry+6yaLgYQUJFKtv+gHV3T6gjYJm6XDqMMVOgNWR4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NtK7Ho7X; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 110A540E0206;
	Sat,  3 May 2025 12:07:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qO-hxwK00kTd; Sat,  3 May 2025 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746274050; bh=xp0Sbz9Zv7k2nPjyqhgjhsdzmEuEZZQ52kdsfDfr8TU=;
	h=Date:From:To:Cc:Subject:From;
	b=NtK7Ho7Xua1WTZ0NdRFhb/reD/GdGIN1EzXDdpCf0nQHgIs97iSObZbDg11BFZvKK
	 Jfqdwg2PVtLjMHE/bCksoP0iccxtJV2Wj5MkFnPeSqdYS1UgX5N62h97hzf8W09rKO
	 oJ7BFChpfRqw3LqOZl0N3S8Pn6NsPzAmflLxTbUruclVK2PbJ3RKbKizx254ydNZwe
	 kKGKXmBxmnlmBLCAKFjJx1WP1JGaKiE46di7osPdDxZ9c4b3lYRp95rmS6p3IfVjVn
	 DXimgcvjTOCx9ZP+lf18mKkA5MA7RXfs0HLSoo0PVRFCTzZ0mOhQ0J8jakGiEpEoQt
	 ITzbF6I81FecLPSSLsyn/GFEDJ/UbnJ3RBeIctu9fZtw1uzutCYtYMKgn+E21F4qXC
	 1OTy6g8WIytYA+/2UQ2nEOdBF7mD+f+CMqFa1ew+a7XuGpumYQvTPbUPsfYsZdsX42
	 64WrkC17HuLyPgDrRyj7Tbwdn4Xtrn23V+AFs/Bsum9Ue/BspFdfRp6v5JffrOOOLM
	 31BaxYiBrfyEZB0HYQxFVisg6R2zpETchVQ0APAtfEuIJCvK96Ku9X9WTQCGr5eRiL
	 sfHg+djY/Yd675KpbKZONB5FsYSNPA30jBEMGPYYZ4d4JGwO2MpXomjgxK8euI3cfY
	 H0EWNlbGBBcxbYYuiHueyC5U=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AEB6A40E0192;
	Sat,  3 May 2025 12:07:18 +0000 (UTC)
Date: Sat, 3 May 2025 14:07:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: hardened_usercopy 32-bit (was: Re: [tip: x86/merge] x86/fpu: Make
 task_struct::thread constant size)
Message-ID: <20250503120712.GJaBYG8A-D77MllFZ3@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Apr 14, 2025 at 07:34:48AM -0000, tip-bot2 for Ingo Molnar wrote:
> The fpu_thread_struct_whitelist() quirk to hardened usercopy can be removed,
> now that the FPU structure is not embedded in the task struct anymore, which
> reduces text footprint a bit.

Well, hardened usercopy still doesn't like it on 32-bit, see splat below:

I did some debugging printks and here's what I see:

That's the loop in copy_uabi_to_xstate(), copying the first FPU state
- XFEATURE_FP - to the kernel buffer:

[    1.752756] copy_uabi_to_xstate: i: 0 dst: 0xcab11f40, offset: 0, size: 160, kbuf: 0x00000000, ubuf: 0xbfcbca80
[    1.754600] copy_from_buffer: dst: 0xcab11f40, src: 0xbfcbca80, size: 160

hardened wants to check it:

[    1.755823] __check_heap_object: ptr: 0xcab11f40, slap_address: 0xcab10000, size: 2944
[    1.757102] __check_heap_object: offset: 2112

and figures out it is in some weird offset 2112 from *task_struct* even
though:

[    1.750149] copy_uabi_to_xstate: sizeof(task_struct): 1984

btw, the buffer is big enough too:

[    1.749077] copy_uabi_to_xstate: sizeof(&fpstate->regs.xsave): 576

but then it decides to BUG because an overwrite attempt is being done on
task_struct which is bollocks now as struct fpu is not part of it anymore.

And this is where I'm all out of ideas so lemme CC folks.

[    1.757898] __check_heap_object: will abort: offset: 2112, size: 160

[    1.758951] usercopy: Kernel memory overwrite attempt detected to SLUB object 'task_struct' (offset 2112, size 160)!
[    1.760651] ------------[ cut here ]------------
[    1.761474] kernel BUG at mm/usercopy.c:102!
[    1.762240] Oops: invalid opcode: 0000 [#1] SMP
[    1.763063] CPU: 6 UID: 0 PID: 1182 Comm: rc Not tainted 6.15.0-rc2+ #35 PREEMPT(full) 
[    1.764374] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    1.765952] EIP: usercopy_abort+0x79/0x88
[    1.768411] Code: c1 89 44 24 0c 0f 45 cb 8b 5d 0c 89 74 24 10 89 4c 24 04 c7 04 24 98 f0 c5 c1 89 5c 24 20 8b 5d 08 89 5c 24 1c e8 d3 8b e7 ff <0f> 0b ba 89 8f ce c1 89 55 f0 89 d6 eb 97 90 3e 8d 74 26 00 85 d2
[    1.771573] EAX: 00000068 EBX: 00000840 ECX: 00000000 EDX: 00000006
[    1.772638] ESI: c1cdb354 EDI: c1ce0c9a EBP: cc751d40 ESP: cc751d0c
[    1.773707] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010292
[    1.774831] CR0: 80050033 CR2: 00511860 CR3: 0cde1000 CR4: 003506d0
[    1.775921] Call Trace:
[    1.776498]  __check_heap_object+0x117/0x14c
[    1.777314]  __check_object_size+0x1af/0x250
[    1.778129]  ? vprintk+0x13/0x1c
[    1.778778]  copy_from_buffer+0xbc/0x114
[    1.779498]  copy_uabi_to_xstate+0x1b7/0x31c
[    1.780251]  copy_sigframe_from_user_to_xstate+0x27/0x34
[    1.781171]  __fpu_restore_sig+0x4ae/0x4c4
[    1.781954]  fpu__restore_sig+0x60/0xb0
[    1.784487]  ia32_restore_sigcontext+0xe4/0x108
[    1.785464]  __do_sys_sigreturn+0x66/0xac
[    1.786191]  ia32_sys_call+0x226a/0x30e0
[    1.786942]  do_int80_syscall_32+0x83/0x158
[    1.787735]  entry_INT80_32+0x108/0x108
[    1.788424] EIP: 0xb7f8b232
[    1.788989] Code: ab 01 00 05 f5 6d 02 00 83 ec 14 8d 80 44 7f ff ff 50 6a 02 e8 df f6 00 00 c7 04 24 7f 00 00 00 e8 7e 9b 01 00 66 90 90 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
[    1.792057] EAX: 000004a0 EBX: ffffffff ECX: bfcbce44 EDX: 00000000
[    1.793184] ESI: 00000000 EDI: 00000001 EBP: 005118c0 ESP: bfcbcde0
[    1.794284] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000286
[    1.795440] Modules linked in:
[    1.796088] ---[ end trace 0000000000000000 ]---
[    1.796932] EIP: usercopy_abort+0x79/0x88
[    1.797671] Code: c1 89 44 24 0c 0f 45 cb 8b 5d 0c 89 74 24 10 89 4c 24 04 c7 04 24 98 f0 c5 c1 89 5c 24 20 8b 5d 08 89 5c 24 1c e8 d3 8b e7 ff <0f> 0b ba 89 8f ce c1 89 55 f0 89 d6 eb 97 90 3e 8d 74 26 00 85 d2
[    1.803256] EAX: 00000068 EBX: 00000840 ECX: 00000000 EDX: 00000006
[    1.804604] ESI: c1cdb354 EDI: c1ce0c9a EBP: cc751d40 ESP: cc751d0c
[    1.805686] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010292
[    1.806814] CR0: 80050033 CR2: 00511860 CR3: 0cde1000 CR4: 003506d0

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

