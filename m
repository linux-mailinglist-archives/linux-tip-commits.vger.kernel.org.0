Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D88D2BC2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Oct 2019 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfJJNvm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Oct 2019 09:51:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56851 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfJJNvm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Oct 2019 09:51:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIYpN-0001jx-6O; Thu, 10 Oct 2019 15:50:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 92DA71C0082;
        Thu, 10 Oct 2019 15:50:00 +0200 (CEST)
Date:   Thu, 10 Oct 2019 13:50:00 -0000
From:   "tip-bot2 for Ralf Ramsauer" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/jailhouse: Only enable platform UARTs if available
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Borislav Petkov <bp@suse.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, jailhouse-dev@googlegroups.com,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191010102102.421035-3-ralf.ramsauer@oth-regensburg.de>
References: <20191010102102.421035-3-ralf.ramsauer@oth-regensburg.de>
MIME-Version: 1.0
Message-ID: <157071540044.9978.10617239388480450385.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     7a56b81c474619fa84c60d07eaa287c8fc33ac3c
Gitweb:        https://git.kernel.org/tip/7a56b81c474619fa84c60d07eaa287c8fc33ac3c
Author:        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
AuthorDate:    Thu, 10 Oct 2019 12:21:02 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Oct 2019 15:43:59 +02:00

x86/jailhouse: Only enable platform UARTs if available

ACPI tables aren't available if Linux runs as guest of the hypervisor
Jailhouse. This makes the 8250 driver probe for all platform UARTs as it
assumes that all UARTs are present in case of !ACPI. Jailhouse will stop
execution of Linux guest due to port access violation.

So far, these access violations were solved by tuning the 8250.nr_uarts
cmdline parameter, but this has limitations: Only consecutive platform
UARTs can be mapped to Linux, and only in the sequence 0x3f8, 0x2f8,
0x3e8, 0x2e8.

Beginning from setup_data version 2, Jailhouse will place information of
available platform UARTs in setup_data. This allows for selective
activation of platform UARTs.

Query setup_data version and only activate available UARTS. This
patch comes with backward compatibility, and will still support older
setup_data versions. In case of older setup_data versions, Linux falls
back to the old behaviour.

Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: jailhouse-dev@googlegroups.com
Cc: Juergen Gross <jgross@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191010102102.421035-3-ralf.ramsauer@oth-regensburg.de
---
 arch/x86/include/uapi/asm/bootparam.h |  3 +-
 arch/x86/kernel/jailhouse.c           | 85 ++++++++++++++++++++++----
 2 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 43be437..db1e24e 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -152,6 +152,9 @@ struct jailhouse_setup_data {
 		__u8	standard_ioapic;
 		__u8	cpu_ids[255];
 	} __attribute__((packed)) v1;
+	struct {
+		__u32	flags;
+	} __attribute__((packed)) v2;
 } __attribute__((packed));
 
 /* The so-called "zeropage" */
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index cf4eb37..6eb8b50 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -11,6 +11,7 @@
 #include <linux/acpi_pmtmr.h>
 #include <linux/kernel.h>
 #include <linux/reboot.h>
+#include <linux/serial_8250.h>
 #include <asm/apic.h>
 #include <asm/cpu.h>
 #include <asm/hypervisor.h>
@@ -21,11 +22,24 @@
 #include <asm/setup.h>
 #include <asm/jailhouse_para.h>
 
-static __initdata struct jailhouse_setup_data setup_data;
+static struct jailhouse_setup_data setup_data;
 #define SETUP_DATA_V1_LEN	(sizeof(setup_data.hdr) + sizeof(setup_data.v1))
+#define SETUP_DATA_V2_LEN	(SETUP_DATA_V1_LEN + sizeof(setup_data.v2))
 
 static unsigned int precalibrated_tsc_khz;
 
+static void jailhouse_setup_irq(unsigned int irq)
+{
+	struct mpc_intsrc mp_irq = {
+		.type		= MP_INTSRC,
+		.irqtype	= mp_INT,
+		.irqflag	= MP_IRQPOL_ACTIVE_HIGH | MP_IRQTRIG_EDGE,
+		.srcbusirq	= irq,
+		.dstirq		= irq,
+	};
+	mp_save_irq(&mp_irq);
+}
+
 static uint32_t jailhouse_cpuid_base(void)
 {
 	if (boot_cpu_data.cpuid_level < 0 ||
@@ -79,11 +93,6 @@ static void __init jailhouse_get_smp_config(unsigned int early)
 		.type = IOAPIC_DOMAIN_STRICT,
 		.ops = &mp_ioapic_irqdomain_ops,
 	};
-	struct mpc_intsrc mp_irq = {
-		.type = MP_INTSRC,
-		.irqtype = mp_INT,
-		.irqflag = MP_IRQPOL_ACTIVE_HIGH | MP_IRQTRIG_EDGE,
-	};
 	unsigned int cpu;
 
 	jailhouse_x2apic_init();
@@ -100,12 +109,12 @@ static void __init jailhouse_get_smp_config(unsigned int early)
 	if (setup_data.v1.standard_ioapic) {
 		mp_register_ioapic(0, 0xfec00000, gsi_top, &ioapic_cfg);
 
-		/* Register 1:1 mapping for legacy UART IRQs 3 and 4 */
-		mp_irq.srcbusirq = mp_irq.dstirq = 3;
-		mp_save_irq(&mp_irq);
-
-		mp_irq.srcbusirq = mp_irq.dstirq = 4;
-		mp_save_irq(&mp_irq);
+		if (IS_ENABLED(CONFIG_SERIAL_8250) &&
+		    setup_data.hdr.version < 2) {
+			/* Register 1:1 mapping for legacy UART IRQs 3 and 4 */
+			jailhouse_setup_irq(3);
+			jailhouse_setup_irq(4);
+		}
 	}
 }
 
@@ -138,6 +147,53 @@ static int __init jailhouse_pci_arch_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_SERIAL_8250
+static inline bool jailhouse_uart_enabled(unsigned int uart_nr)
+{
+	return setup_data.v2.flags & BIT(uart_nr);
+}
+
+static void jailhouse_serial_fixup(int port, struct uart_port *up,
+				   u32 *capabilities)
+{
+	static const u16 pcuart_base[] = {0x3f8, 0x2f8, 0x3e8, 0x2e8};
+	unsigned int n;
+
+	for (n = 0; n < ARRAY_SIZE(pcuart_base); n++) {
+		if (pcuart_base[n] != up->iobase)
+			continue;
+
+		if (jailhouse_uart_enabled(n)) {
+			pr_info("Enabling UART%u (port 0x%lx)\n", n,
+				up->iobase);
+			jailhouse_setup_irq(up->irq);
+		} else {
+			/* Deactivate UART if access isn't allowed */
+			up->iobase = 0;
+		}
+		break;
+	}
+}
+
+static void __init jailhouse_serial_workaround(void)
+{
+	/*
+	 * There are flags inside setup_data that indicate availability of
+	 * platform UARTs since setup data version 2.
+	 *
+	 * In case of version 1, we don't know which UARTs belong Linux. In
+	 * this case, unconditionally register 1:1 mapping for legacy UART IRQs
+	 * 3 and 4.
+	 */
+	if (setup_data.hdr.version > 1)
+		serial8250_set_isa_configurator(jailhouse_serial_fixup);
+}
+#else /* !CONFIG_SERIAL_8250 */
+static inline void jailhouse_serial_workaround(void)
+{
+}
+#endif /* CONFIG_SERIAL_8250 */
+
 static void __init jailhouse_init_platform(void)
 {
 	u64 pa_data = boot_params.hdr.setup_data;
@@ -189,7 +245,8 @@ static void __init jailhouse_init_platform(void)
 	if (setup_data.hdr.version == 0 ||
 	    setup_data.hdr.compatible_version !=
 		JAILHOUSE_SETUP_REQUIRED_VERSION ||
-	    (setup_data.hdr.version >= 1 && header.len < SETUP_DATA_V1_LEN))
+	    (setup_data.hdr.version == 1 && header.len < SETUP_DATA_V1_LEN) ||
+	    (setup_data.hdr.version >= 2 && header.len < SETUP_DATA_V2_LEN))
 		goto unsupported;
 
 	pmtmr_ioport = setup_data.v1.pm_timer_address;
@@ -205,6 +262,8 @@ static void __init jailhouse_init_platform(void)
 	 * are none in a non-root cell.
 	 */
 	disable_acpi();
+
+	jailhouse_serial_workaround();
 	return;
 
 unsupported:
