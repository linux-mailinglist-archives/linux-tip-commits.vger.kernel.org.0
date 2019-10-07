Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB2F4CE5B5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Oct 2019 16:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfJGOtt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 7 Oct 2019 10:49:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44534 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfJGOts (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:48 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUKQ-0006Ep-Qt; Mon, 07 Oct 2019 16:49:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8B87E1C0895;
        Mon,  7 Oct 2019 16:49:34 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:34 -0000
From:   "tip-bot2 for Hans de Goede" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot: Provide memzero_explicit()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007134724.4019-1-hdegoede@redhat.com>
References: <20191007134724.4019-1-hdegoede@redhat.com>
MIME-Version: 1.0
Message-ID: <157045977450.9978.18318761982949903126.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ee008a19f1c72c37ffa54326a592035dddb66fd6
Gitweb:        https://git.kernel.org/tip/ee008a19f1c72c37ffa54326a592035dddb66fd6
Author:        Hans de Goede <hdegoede@redhat.com>
AuthorDate:    Mon, 07 Oct 2019 15:47:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 07 Oct 2019 16:47:35 +02:00

x86/boot: Provide memzero_explicit()

The purgatory code now uses the shared lib/crypto/sha256.c sha256
implementation. This needs memzero_explicit(), implement this.

We also have barrier_data() call after the memset, making sure
neither the compiler nor the linker optimizes out this seemingly
unused function.

Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-crypto@vger.kernel.org
Fixes: 906a4bb97f5d ("crypto: sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
Link: https://lkml.kernel.org/r/20191007134724.4019-1-hdegoede@redhat.com
[ Added comment. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/string.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
index 81fc1ea..dd30e63 100644
--- a/arch/x86/boot/compressed/string.c
+++ b/arch/x86/boot/compressed/string.c
@@ -50,6 +50,16 @@ void *memset(void *s, int c, size_t n)
 	return s;
 }
 
+void memzero_explicit(void *s, size_t count)
+{
+	memset(s, 0, count);
+	/*
+	 * Make sure this function never gets inlined and
+	 * the memset() never gets optimized away:
+	 */
+	barrier_data(s);
+}
+
 void *memmove(void *dest, const void *src, size_t n)
 {
 	unsigned char *d = dest;
