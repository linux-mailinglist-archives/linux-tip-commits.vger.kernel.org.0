Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9692440BE1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 30 Oct 2021 23:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhJ3Vgu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 30 Oct 2021 17:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhJ3VgK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 30 Oct 2021 17:36:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84597C0797B6;
        Sat, 30 Oct 2021 14:32:25 -0700 (PDT)
Date:   Sat, 30 Oct 2021 21:32:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635629544;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4DkWvVjThW7duWCs5Ez/pFvXLxLx9Y5fu5BNHGrb1I=;
        b=t6ZW9ycARmb0nsyYHfsc3p+p1yd1db9BhJANnSy1u5xUh3AmPIn3nQLXnU+Kf4K3+NysfR
        0S67xyOkGygphtr9wzFqJucjek78RJMN0MYNnc6Ktmq6HMn3yZC047IFN1RMWDeNkZVT7H
        g4w2RbfUD37Ws6n7S3LDNKCKxWKYWEUOi5h5vIM8BFlt3las7pGaz+xtooYURkALhN+JBs
        p+NYXl7md+TkrabF4PWIGDEyoPoR75NpGyx34J+sKCAhtkwuYyNK93R1g7btdkwnk9Hubk
        yfaUavKc06rIR3FhDuwvoVi1znje1F5wvGsJ53jUH7s0AksRQ6zGEg2DNCE+Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635629544;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4DkWvVjThW7duWCs5Ez/pFvXLxLx9Y5fu5BNHGrb1I=;
        b=7PPObh6W6P4/wK/f0Oaedylmh67O0Ox8Ph0Yh+wPkrygLScQaK1rj90JC092ZtuXxSFlcB
        kI/qC6u9GixFklDw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] selftests/x86/iopl: Adjust to the faked iopl CLI/STI usage
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211030083939.13073-1-bp@alien8.de>
References: <20211030083939.13073-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163562954308.626.8903154576094573633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     a72fdfd21e01c626273ddcf5ab740d4caef4be54
Gitweb:        https://git.kernel.org/tip/a72fdfd21e01c626273ddcf5ab740d4caef4be54
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 29 Oct 2021 19:27:32 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 30 Oct 2021 23:18:04 +02:00

selftests/x86/iopl: Adjust to the faked iopl CLI/STI usage

Commit in Fixes changed the iopl emulation to not #GP on CLI and STI
because it would break some insane luserspace tools which would toggle
interrupts.

The corresponding selftest would rely on the fact that executing CLI/STI
would trigger a #GP and thus detect it this way but since that #GP is
not happening anymore, the detection is now wrong too.

Extend the test to actually look at the IF flag and whether executing
those insns had any effect on it. The STI detection needs to have the
fact that interrupts were previously disabled, passed in so do that from
the previous CLI test, i.e., STI test needs to follow a previous CLI one
for it to make sense.

Fixes: b968e84b509d ("x86/iopl: Fake iopl(3) CLI/STI usage")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20211030083939.13073-1-bp@alien8.de
---
 tools/testing/selftests/x86/iopl.c | 78 +++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/x86/iopl.c b/tools/testing/selftests/x86/iopl.c
index bab2f6e..7e3e09c 100644
--- a/tools/testing/selftests/x86/iopl.c
+++ b/tools/testing/selftests/x86/iopl.c
@@ -85,48 +85,88 @@ static void expect_gp_outb(unsigned short port)
 	printf("[OK]\toutb to 0x%02hx failed\n", port);
 }
 
-static bool try_cli(void)
+#define RET_FAULTED	0
+#define RET_FAIL	1
+#define RET_EMUL	2
+
+static int try_cli(void)
 {
+	unsigned long flags;
+
 	sethandler(SIGSEGV, sigsegv, SA_RESETHAND);
 	if (sigsetjmp(jmpbuf, 1) != 0) {
-		return false;
+		return RET_FAULTED;
 	} else {
-		asm volatile ("cli");
-		return true;
+		asm volatile("cli; pushf; pop %[flags]"
+				: [flags] "=rm" (flags));
+
+		/* X86_FLAGS_IF */
+		if (!(flags & (1 << 9)))
+			return RET_FAIL;
+		else
+			return RET_EMUL;
 	}
 	clearhandler(SIGSEGV);
 }
 
-static bool try_sti(void)
+static int try_sti(bool irqs_off)
 {
+	unsigned long flags;
+
 	sethandler(SIGSEGV, sigsegv, SA_RESETHAND);
 	if (sigsetjmp(jmpbuf, 1) != 0) {
-		return false;
+		return RET_FAULTED;
 	} else {
-		asm volatile ("sti");
-		return true;
+		asm volatile("sti; pushf; pop %[flags]"
+				: [flags] "=rm" (flags));
+
+		/* X86_FLAGS_IF */
+		if (irqs_off && (flags & (1 << 9)))
+			return RET_FAIL;
+		else
+			return RET_EMUL;
 	}
 	clearhandler(SIGSEGV);
 }
 
-static void expect_gp_sti(void)
+static void expect_gp_sti(bool irqs_off)
 {
-	if (try_sti()) {
+	int ret = try_sti(irqs_off);
+
+	switch (ret) {
+	case RET_FAULTED:
+		printf("[OK]\tSTI faulted\n");
+		break;
+	case RET_EMUL:
+		printf("[OK]\tSTI NOPped\n");
+		break;
+	default:
 		printf("[FAIL]\tSTI worked\n");
 		nerrs++;
-	} else {
-		printf("[OK]\tSTI faulted\n");
 	}
 }
 
-static void expect_gp_cli(void)
+/*
+ * Returns whether it managed to disable interrupts.
+ */
+static bool test_cli(void)
 {
-	if (try_cli()) {
+	int ret = try_cli();
+
+	switch (ret) {
+	case RET_FAULTED:
+		printf("[OK]\tCLI faulted\n");
+		break;
+	case RET_EMUL:
+		printf("[OK]\tCLI NOPped\n");
+		break;
+	default:
 		printf("[FAIL]\tCLI worked\n");
 		nerrs++;
-	} else {
-		printf("[OK]\tCLI faulted\n");
+		return true;
 	}
+
+	return false;
 }
 
 int main(void)
@@ -152,8 +192,7 @@ int main(void)
 	}
 
 	/* Make sure that CLI/STI are blocked even with IOPL level 3 */
-	expect_gp_cli();
-	expect_gp_sti();
+	expect_gp_sti(test_cli());
 	expect_ok_outb(0x80);
 
 	/* Establish an I/O bitmap to test the restore */
@@ -204,8 +243,7 @@ int main(void)
 	printf("[RUN]\tparent: write to 0x80 (should fail)\n");
 
 	expect_gp_outb(0x80);
-	expect_gp_cli();
-	expect_gp_sti();
+	expect_gp_sti(test_cli());
 
 	/* Test the capability checks. */
 	printf("\tiopl(3)\n");
