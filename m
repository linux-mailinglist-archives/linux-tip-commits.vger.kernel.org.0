Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDC71B5053
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Apr 2020 00:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgDVW0X (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Apr 2020 18:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726557AbgDVWYy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Apr 2020 18:24:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56AC03C1A9;
        Wed, 22 Apr 2020 15:24:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnQ-0001Pv-F8; Thu, 23 Apr 2020 00:24:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F0B2C1C0493;
        Thu, 23 Apr 2020 00:24:41 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:41 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix 32bit cross builds
Cc:     youling257@gmail.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158759428124.28353.6211988473757246611.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     df2b384366fc427eeaa8bd0e761390180b311df0
Gitweb:        https://git.kernel.org/tip/df2b384366fc427eeaa8bd0e761390180b311df0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 20 Apr 2020 10:33:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:09:50 +02:00

objtool: Fix 32bit cross builds

Apparently there's people doing 64bit builds on 32bit machines.

Fixes: 74b873e49d92 ("objtool: Optimize find_rela_by_dest_range()")
Reported-by: youling257@gmail.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index ebbb10c..0b79c23 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -99,7 +99,7 @@ static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
 	offset &= OFFSET_STRIDE_MASK;
 
 	ol = offset;
-	oh = offset >> 32;
+	oh = (offset >> 16) >> 16;
 
 	__jhash_mix(ol, oh, idx);
 
