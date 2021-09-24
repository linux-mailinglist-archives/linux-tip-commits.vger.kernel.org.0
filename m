Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76DF41706D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Sep 2021 12:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244728AbhIXKqz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 24 Sep 2021 06:46:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41190 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhIXKqx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 24 Sep 2021 06:46:53 -0400
Date:   Fri, 24 Sep 2021 10:45:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632480319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QC1Zmi/OXCL9LTXdUwZ7DHvcDGZgdrX8haxzTkA8RnM=;
        b=zRbG4TzktzzZuNLhdEbGasFOXx0MSxfWAnlZ9MivNZqIK27Vv3WPyJi10I8jgWtCEiOF8f
        A7EMSVTKsEk5p3FQuvJwSmBfqRC1gSZ18obzzWOHeDjTropRP3f69cD7kmD8eFRERrG0pr
        dj6/vi4eocnplYEvQBSS8ULLAhxv6DpaSw2M5QtWf5O0oKOW16CPs99AQChRTXl4k/E3Tu
        cBKZK6wqnjeNAI9ph7KqZgYgzXIgmZH7rDFG3UiVHQYUCyDU7HnMkEnxhhb5k2twRU97Sa
        KS0g8mGaoMXeSpL84H7l2To3Xwo64AfRIV7bwpPdrhH01kElZFGZ2vUSNBhT4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632480319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QC1Zmi/OXCL9LTXdUwZ7DHvcDGZgdrX8haxzTkA8RnM=;
        b=GHloRE7zfaNW3c3G4BO+DaW1aGgh7ylNIyjPMwhBPbaTdvKfXn4SUjFz2n/27RBLAsC/72
        ngBvHFKXmNAXt6AA==
From:   "tip-bot2 for Numfor Mbiziwo-Tiapo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/insn, tools/x86: Fix undefined behavior due to
 potential unaligned accesses
Cc:     "Numfor Mbiziwo-Tiapo" <nums@google.com>,
        Ian Rogers <irogers@google.com>, Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923161843.751834-1-irogers@google.com>
References: <20210923161843.751834-1-irogers@google.com>
MIME-Version: 1.0
Message-ID: <163248031804.25758.7658032205520387028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5ba1071f7554c4027bdbd712a146111de57918de
Gitweb:        https://git.kernel.org/tip/5ba1071f7554c4027bdbd712a146111de57918de
Author:        Numfor Mbiziwo-Tiapo <nums@google.com>
AuthorDate:    Thu, 23 Sep 2021 09:18:43 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 24 Sep 2021 12:37:38 +02:00

x86/insn, tools/x86: Fix undefined behavior due to potential unaligned accesses

Don't perform unaligned loads in __get_next() and __peek_nbyte_next() as
these are forms of undefined behavior:

"A pointer to an object or incomplete type may be converted to a pointer
to a different object or incomplete type. If the resulting pointer
is not correctly aligned for the pointed-to type, the behavior is
undefined."

(from http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf)

These problems were identified using the undefined behavior sanitizer
(ubsan) with the tools version of the code and perf test.

 [ bp: Massage commit message. ]

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20210923161843.751834-1-irogers@google.com
---
 arch/x86/lib/insn.c       | 4 ++--
 tools/arch/x86/lib/insn.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 058f19b..c565def 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -37,10 +37,10 @@
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
+	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
+	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index c41f958..7976994 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -37,10 +37,10 @@
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
+	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
+	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
