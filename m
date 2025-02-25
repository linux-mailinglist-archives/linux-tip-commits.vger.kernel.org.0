Return-Path: <linux-tip-commits+bounces-3624-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C75A44F42
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 22:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A677AA8F9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 21:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FDB212B38;
	Tue, 25 Feb 2025 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NqApXhHl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3+REmFG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446220FA9E;
	Tue, 25 Feb 2025 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520345; cv=none; b=Fjb81pwUl+sZoT2QSP0aZO02A1Mh8T43HEtBS+m03Zr3MgKQDixktIoKNMJyKEBkIeaQork5iyIFfqxs5uxOB8hB+ZeyHAmJs7+xu8gue1BHWD8sYT8CMlY7LD1IIIe1PnkTuN/fbhtv2QKZJPHBetHRw/UVxoWwLbMFe82Y47I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520345; c=relaxed/simple;
	bh=EkgP9w6/bdiMS2k43ItnJ9qXnJAWv56ObwRU0pbjUg0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Og7fDi79RY8uVg6mCNM9D7+V7tBt8zqqfd4IWo5fc3I+A0JKtrDxL4N9fTsUqPandmnW1XQF2B71WLp2a55Qed5sqNarp8EVhoc9nUBHXAOnp3JwRc2dq8oxkdtOALaHM4h9lEjyJsGMB7HZ3DAEqtuUDLcpBrciN57GhLwVf/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NqApXhHl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v3+REmFG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 21:52:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740520341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoKY9Ur2qsmMd+voVsP00YjHJ+OXTo+/MxuABB/abSg=;
	b=NqApXhHlYb0tGjOv67MkTabuCYVJf9L1rhw9gUOF2bQcOnYrRjA4gG84mSSap9Ap1mK1Sa
	65zqu8NVLQXr9Wj1Bv0/P1MF2XPyeaVqWdCZ9trHE/lF3BTUkwrESOtM/ka/BnItXSIyq/
	35To8I0nisafTGwug4Wwan/JJ7+zN4G2SfHkoD350JrFgk+zJX4ksn4r/ZxA5gpkuv3QH0
	JEqHnHRZGf3dHj0EKyfgqIUxkDy3U9SbenV9bHvucP0F/50Ef+31lo2LfPdsY88aUyFyCi
	TYV8KYJD7xWr7TvA/lRH+5EhCTY4o4yhEm0YnJV3TIlDwUHSYiGclxZyPv4zSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740520341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoKY9Ur2qsmMd+voVsP00YjHJ+OXTo+/MxuABB/abSg=;
	b=v3+REmFGc9ANH0S9agLY+pLna3U4GyAD8xtqQaGSjSCwT7t9zkQdMQWJsFb1CuibLCLQp8
	CEIwG4NgdKiQIyDA==
From: "tip-bot2 for Russell Senior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU: Fix warm boot hang regression on AMD
 SC1100 SoC systems
Cc: Russell Senior <russell@personaltelco.net>, Ingo Molnar <mingo@kernel.org>,
 Matthew Whitehead <tedheadster@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <CAHP3WfOgs3Ms4Z+L9i0-iBOE21sdMk5erAiJurPjnrL9LSsgRA@mail.gmail.com>
References:
 <CAHP3WfOgs3Ms4Z+L9i0-iBOE21sdMk5erAiJurPjnrL9LSsgRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174052034115.10177.15718168706868821118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     bebe35bb738b573c32a5033499cd59f20293f2a3
Gitweb:        https://git.kernel.org/tip/bebe35bb738b573c32a5033499cd59f20293f2a3
Author:        Russell Senior <russell@personaltelco.net>
AuthorDate:    Tue, 25 Feb 2025 22:31:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 22:44:01 +01:00

x86/CPU: Fix warm boot hang regression on AMD SC1100 SoC systems

I still have some Soekris net4826 in a Community Wireless Network I
volunteer with. These devices use an AMD SC1100 SoC. I am running
OpenWrt on them, which uses a patched kernel, that naturally has
evolved over time.  I haven't updated the ones in the field in a
number of years (circa 2017), but have one in a test bed, where I have
intermittently tried out test builds.

A few years ago, I noticed some trouble, particularly when "warm
booting", that is, doing a reboot without removing power, and noticed
the device was hanging after the kernel message:

  [    0.081615] Working around Cyrix MediaGX virtual DMA bugs.

If I removed power and then restarted, it would boot fine, continuing
through the message above, thusly:

  [    0.081615] Working around Cyrix MediaGX virtual DMA bugs.
  [    0.090076] Enable Memory-Write-back mode on Cyrix/NSC processor.
  [    0.100000] Enable Memory access reorder on Cyrix/NSC processor.
  [    0.100070] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
  [    0.110058] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
  [    0.120037] CPU: NSC Geode(TM) Integrated Processor by National Semi (family: 0x5, model: 0x9, stepping: 0x1)
  [...]

In order to continue using modern tools, like ssh, to interact with
the software on these old devices, I need modern builds of the OpenWrt
firmware on the devices. I confirmed that the warm boot hang was still
an issue in modern OpenWrt builds (currently using a patched linux
v6.6.65).

Last night, I decided it was time to get to the bottom of the warm
boot hang, and began bisecting. From preserved builds, I narrowed down
the bisection window from late February to late May 2019. During this
period, the OpenWrt builds were using 4.14.x. I was able to build
using period-correct Ubuntu 18.04.6. After a number of bisection
iterations, I identified a kernel bump from 4.14.112 to 4.14.113 as
the commit that introduced the warm boot hang.

  https://github.com/openwrt/openwrt/commit/07aaa7e3d62ad32767d7067107db64b6ade81537

Looking at the upstream changes in the stable kernel between 4.14.112
and 4.14.113 (tig v4.14.112..v4.14.113), I spotted a likely suspect:

  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=20afb90f730982882e65b01fb8bdfe83914339c5

So, I tried reverting just that kernel change on top of the breaking
OpenWrt commit, and my warm boot hang went away.

Presumably, the warm boot hang is due to some register not getting
cleared in the same way that a loss of power does. That is
approximately as much as I understand about the problem.

More poking/prodding and coaching from Jonas Gorski, it looks
like this test patch fixes the problem on my board: Tested against
v6.6.67 and v4.14.113.

Fixes: 18fb053f9b82 ("x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors")
Debugged-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Russell Senior <russell@personaltelco.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/CAHP3WfOgs3Ms4Z+L9i0-iBOE21sdMk5erAiJurPjnrL9LSsgRA@mail.gmail.com
Cc: Matthew Whitehead <tedheadster@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/cyrix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 9651275..dfec2c6 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -153,8 +153,8 @@ static void geode_configure(void)
 	u8 ccr3;
 	local_irq_save(flags);
 
-	/* Suspend on halt power saving and enable #SUSP pin */
-	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
+	/* Suspend on halt power saving */
+	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x08);
 
 	ccr3 = getCx86(CX86_CCR3);
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* enable MAPEN */

