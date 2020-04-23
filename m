Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38C01B5681
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Apr 2020 09:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgDWHuL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Apr 2020 03:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgDWHt5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB89C03C1AF;
        Thu, 23 Apr 2020 00:49:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWcL-0008Vo-QU; Thu, 23 Apr 2020 09:49:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 241851C0809;
        Thu, 23 Apr 2020 09:49:48 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:47 -0000
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix off-by-one in symbol_by_offset()
Cc:     Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158762818772.28353.1104366347915918355.tip-bot2@tip-bot2>
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

Commit-ID:     5377cae94ae31b089d4a69e7706672501c974f4d
Gitweb:        https://git.kernel.org/tip/5377cae94ae31b089d4a69e7706672501c974f4d
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 03 Apr 2020 14:17:30 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:49 +02:00

objtool: Fix off-by-one in symbol_by_offset()

Sometimes, WARN_FUNC() and other users of symbol_by_offset() will
associate the first instruction of a symbol with the symbol preceding
it.  This is because symbol->offset + symbol->len is already outside of
the symbol's range.

Fixes: 2a362ecc3ec9 ("objtool: Optimize find_symbol_*() and read_symbols()")
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 09ddc8f..c4857fa 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -105,7 +105,7 @@ static int symbol_by_offset(const void *key, const struct rb_node *node)
 
 	if (*o < s->offset)
 		return -1;
-	if (*o > s->offset + s->len)
+	if (*o >= s->offset + s->len)
 		return 1;
 
 	return 0;
