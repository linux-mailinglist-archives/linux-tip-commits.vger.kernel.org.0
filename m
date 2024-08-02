Return-Path: <linux-tip-commits+bounces-1925-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6549E9461DA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 18:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89ADF1C20EA4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3139E27447;
	Fri,  2 Aug 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bcJ/AGGf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OqVuiDTt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3116BE02;
	Fri,  2 Aug 2024 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616505; cv=none; b=H4nFL8I446fFJjUzVMRRWi/+lNz5sRUKVerog587r1ecCNj52lYKcLzhU+w67H6CWtRB9AH3oxPPabmCIzII593mqLkolCBLUfnW+DBkZ+mPNw/bMSpE8gl3rM1CHKVelriZ32FIlrolBmIz4Vl7Ik7GCs3UUsnC0BMBJq33wgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616505; c=relaxed/simple;
	bh=LQ0wsY9k2eAlFmtHFROT4nPVibOu2YiJXvUCgkohVyQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Du3Xdyi0G6mlcsiZQVaqKfps2CuUHzUvG0n3AC2n15Juy8UI9yeCSPBs20EdcoxwNQvyB0RCbHQk3HDWWRaQGr7NTNVOL04AgA/LaDyiF4GkPHmq613sfPx8xMugWpsRsJd6slr3VUUWOXcWqd4mWrHrLq6TrForXGrNUTCZaFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bcJ/AGGf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OqVuiDTt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 16:35:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722616501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTWCG/E/2xayrRI2kd6a1PisnLOKxKx934jJybYG5J8=;
	b=bcJ/AGGftAzcm07vDDteUtV7Fcc0NExwp4HEYnbWu08+y3BMHfDaXPOIWFE6weTbSHMGmw
	veM6ZL9Qw4RLuJ62vfB4qlGZ3pLu6Y27p2MqJOFHIO+UrARKWWPEPGu332Dro8WnxVT2Fv
	c5y0aJ1GniIiI7zZzoRLuZHZW3PQkdmjnpk1fCYmllwoTDzDwaPNfEaJMdF/KUcL4aFBOJ
	UUZwx/HlN0okKUoe6ZKk+GKAkdxH1P44HGRZ+2Iff5Q9udqY3iuuox8rri2B07O4Jyfrs8
	ba/wvvqXJft95r2SrkXJ7BDebo4qgpNqE+Z/15A+lv2RSOWlNNk2KhgSTPfy1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722616501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTWCG/E/2xayrRI2kd6a1PisnLOKxKx934jJybYG5J8=;
	b=OqVuiDTtzeaImu6pT2CdOHeHwOw21jg6t/8SfgD/y4bmKNmFizXCLQNTBF7ZTmzngZGd0w
	1W16MJ6/mt8mbvAw==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/timers] clockevents/drivers/i8253: Fix stop sequence for timer 0
Cc: Sean Christopherson <seanjc@google.com>,
 Li RongQing <lirongqing@baidu.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Thomas Gleixner <tglx@linutronix.de>, Michael Kelley <mhkelley@outlook.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240802135555.564941-2-dwmw2@infradead.org>
References: <20240802135555.564941-2-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172261650143.2215.14522163061233759917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/timers branch of tip:

Commit-ID:     531b2ca0a940ac9db03f246c8b77c4201de72b00
Gitweb:        https://git.kernel.org/tip/531b2ca0a940ac9db03f246c8b77c4201de72b00
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Fri, 02 Aug 2024 14:55:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 18:27:05 +02:00

clockevents/drivers/i8253: Fix stop sequence for timer 0

According to the data sheet, writing the MODE register should stop the
counter (and thus the interrupts). This appears to work on real hardware,
at least modern Intel and AMD systems. It should also work on Hyper-V.

However, on some buggy virtual machines the mode change doesn't have any
effect until the counter is subsequently loaded (or perhaps when the IRQ
next fires).

So, set MODE 0 and then load the counter, to ensure that those buggy VMs
do the right thing and the interrupts stop. And then write MODE 0 *again*
to stop the counter on compliant implementations too.

Apparently, Hyper-V keeps firing the IRQ *repeatedly* even in mode zero
when it should only happen once, but the second MODE write stops that too.

Userspace test program (mostly written by tglx):
=====
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdint.h>
 #include <sys/io.h>

static __always_inline void __out##bwl(type value, uint16_t port)	\
{									\
	asm volatile("out" #bwl " %" #bw "0, %w1"			\
		     : : "a"(value), "Nd"(port));			\
}									\
									\
static __always_inline type __in##bwl(uint16_t port)			\
{									\
	type value;							\
	asm volatile("in" #bwl " %w1, %" #bw "0"			\
		     : "=a"(value) : "Nd"(port));			\
	return value;							\
}

BUILDIO(b, b, uint8_t)

 #define inb __inb
 #define outb __outb

 #define PIT_MODE	0x43
 #define PIT_CH0	0x40
 #define PIT_CH2	0x42

static int is8254;

static void dump_pit(void)
{
	if (is8254) {
		// Latch and output counter and status
		outb(0xC2, PIT_MODE);
		printf("%02x %02x %02x\n", inb(PIT_CH0), inb(PIT_CH0), inb(PIT_CH0));
	} else {
		// Latch and output counter
		outb(0x0, PIT_MODE);
		printf("%02x %02x\n", inb(PIT_CH0), inb(PIT_CH0));
	}
}

int main(int argc, char* argv[])
{
	int nr_counts = 2;

	if (argc > 1)
		nr_counts = atoi(argv[1]);

	if (argc > 2)
		is8254 = 1;

	if (ioperm(0x40, 4, 1) != 0)
		return 1;

	dump_pit();

	printf("Set oneshot\n");
	outb(0x38, PIT_MODE);
	outb(0x00, PIT_CH0);
	outb(0x0F, PIT_CH0);

	dump_pit();
	usleep(1000);
	dump_pit();

	printf("Set periodic\n");
	outb(0x34, PIT_MODE);
	outb(0x00, PIT_CH0);
	outb(0x0F, PIT_CH0);

	dump_pit();
	usleep(1000);
	dump_pit();
	dump_pit();
	usleep(100000);
	dump_pit();
	usleep(100000);
	dump_pit();

	printf("Set stop (%d counter writes)\n", nr_counts);
	outb(0x30, PIT_MODE);
	while (nr_counts--)
		outb(0xFF, PIT_CH0);

	dump_pit();
	usleep(100000);
	dump_pit();
	usleep(100000);
	dump_pit();

	printf("Set MODE 0\n");
	outb(0x30, PIT_MODE);

	dump_pit();
	usleep(100000);
	dump_pit();
	usleep(100000);
	dump_pit();

	return 0;
}
=====

Suggested-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhkelley@outlook.com>
Link: https://lore.kernel.org/all/20240802135555.564941-2-dwmw2@infradead.org

---
 arch/x86/kernel/cpu/mshyperv.c | 11 +----------
 drivers/clocksource/i8253.c    | 36 ++++++++++++++++++++++-----------
 include/linux/i8253.h          |  1 +-
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a..3d4237f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -16,7 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kexec.h>
-#include <linux/i8253.h>
 #include <linux/random.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
@@ -522,16 +521,6 @@ static void __init ms_hyperv_init_platform(void)
 	if (efi_enabled(EFI_BOOT))
 		x86_platform.get_nmi_reason = hv_get_nmi_reason;
 
-	/*
-	 * Hyper-V VMs have a PIT emulation quirk such that zeroing the
-	 * counter register during PIT shutdown restarts the PIT. So it
-	 * continues to interrupt @18.2 HZ. Setting i8253_clear_counter
-	 * to false tells pit_shutdown() not to zero the counter so that
-	 * the PIT really is shutdown. Generation 2 VMs don't have a PIT,
-	 * and setting this value has no effect.
-	 */
-	i8253_clear_counter_on_shutdown = false;
-
 #if IS_ENABLED(CONFIG_HYPERV)
 	if ((hv_get_isolation_type() == HV_ISOLATION_TYPE_VBS) ||
 	    ms_hyperv.paravisor_present)
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index cb215e6..39f7c2d 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -20,13 +20,6 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
-/*
- * Handle PIT quirk in pit_shutdown() where zeroing the counter register
- * restarts the PIT, negating the shutdown. On platforms with the quirk,
- * platform specific code can set this to false.
- */
-bool i8253_clear_counter_on_shutdown __ro_after_init = true;
-
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -112,12 +105,33 @@ void clockevent_i8253_disable(void)
 {
 	raw_spin_lock(&i8253_lock);
 
+	/*
+	 * Writing the MODE register should stop the counter, according to
+	 * the datasheet. This appears to work on real hardware (well, on
+	 * modern Intel and AMD boxes; I didn't dig the Pegasos out of the
+	 * shed).
+	 *
+	 * However, some virtual implementations differ, and the MODE change
+	 * doesn't have any effect until either the counter is written (KVM
+	 * in-kernel PIT) or the next interrupt (QEMU). And in those cases,
+	 * it may not stop the *count*, only the interrupts. Although in
+	 * the virt case, that probably doesn't matter, as the value of the
+	 * counter will only be calculated on demand if the guest reads it;
+	 * it's the interrupts which cause steal time.
+	 *
+	 * Hyper-V apparently has a bug where even in mode 0, the IRQ keeps
+	 * firing repeatedly if the counter is running. But it *does* do the
+	 * right thing when the MODE register is written.
+	 *
+	 * So: write the MODE and then load the counter, which ensures that
+	 * the IRQ is stopped on those buggy virt implementations. And then
+	 * write the MODE again, which is the right way to stop it.
+	 */
 	outb_p(0x30, PIT_MODE);
+	outb_p(0, PIT_CH0);
+	outb_p(0, PIT_CH0);
 
-	if (i8253_clear_counter_on_shutdown) {
-		outb_p(0, PIT_CH0);
-		outb_p(0, PIT_CH0);
-	}
+	outb_p(0x30, PIT_MODE);
 
 	raw_spin_unlock(&i8253_lock);
 }
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index bf169cf..56c280e 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,7 +21,6 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
 
 extern raw_spinlock_t i8253_lock;
-extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
 extern void clockevent_i8253_disable(void);

