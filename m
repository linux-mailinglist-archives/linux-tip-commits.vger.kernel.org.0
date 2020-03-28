Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D43E196580
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Mar 2020 12:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgC1LGW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 28 Mar 2020 07:06:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55620 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgC1LGV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 28 Mar 2020 07:06:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9IB-0003tu-3x; Sat, 28 Mar 2020 12:06:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C0C641C03A9;
        Sat, 28 Mar 2020 12:06:18 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:06:18 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] objtool: whitelist __sanitizer_cov_trace_switch()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539357839.28353.14111713374750758900.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     36b1c7006736517f5a9d86eb6f8d5930a2aa64bf
Gitweb:        https://git.kernel.org/tip/36b1c7006736517f5a9d86eb6f8d5930a2aa64bf
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sun, 16 Feb 2020 13:07:49 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Fri, 27 Mar 2020 23:58:53 -04:00

objtool: whitelist __sanitizer_cov_trace_switch()

it's not really different from e.g. __sanitizer_cov_trace_cmp4();
as it is, the switches that generate an array of labels get
rejected by objtool, while slightly different set of cases
that gets compiled into a series of comparisons is accepted.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4768d91..3667c5d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -478,6 +478,7 @@ static const char *uaccess_safe_builtin[] = {
 	"__sanitizer_cov_trace_cmp2",
 	"__sanitizer_cov_trace_cmp4",
 	"__sanitizer_cov_trace_cmp8",
+	"__sanitizer_cov_trace_switch",
 	/* UBSAN */
 	"ubsan_type_mismatch_common",
 	"__ubsan_handle_type_mismatch",
