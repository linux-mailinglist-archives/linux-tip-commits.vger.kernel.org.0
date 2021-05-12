Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2063037EDD2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhELUzR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 16:55:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243380AbhELSdp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 14:33:45 -0400
Date:   Wed, 12 May 2021 18:32:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620844352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GL+KN12V2WLlmTN5qmieIkFJpA5O3CkALUJ4v9GhZ0M=;
        b=BcpmxlJrVK9DhuCoFKi8BSGzLPrNDpthK4DPOuFYWMZCg59ooPUn9ERFXe1yz/8z4u0Olj
        mxm+OFffaZn0AHXH1nJcrMaENqLSJ7DfvpjbP2g8lSj5z4XG7sKpO36nUC8sosoqhbZPYF
        mOVAlMsESlIyo4xrScspQFhs6r513yn7XLZaRLM/AxbjdUIZqLCA+l1Wh2Uj9MKINTLKyG
        cxIIEr7qmgVr4zJyVOPTmMCKiMxfXlcNsuEkUjqnlaTPnaACcxVwawpgpSosMfWzMu6zx/
        8QzCkxPDeC208YzJ85iPa6YmHGsf6+5tFhaXD/t8CmYi0M79sgKaFllJsZZF5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620844352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GL+KN12V2WLlmTN5qmieIkFJpA5O3CkALUJ4v9GhZ0M=;
        b=qh0dnRcxq+qQtW22145R4o6XVeafFN3xx2UFxNWaJg/0D5EmMckYEpzRJZXtwcVhNPuvTK
        GBwnzdRcR+NZvRAw==
From:   "tip-bot2 for Vasily Gorbik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix elf_create_undef_symbol() endianness
Cc:     Vasily Gorbik <gor@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cpatch-1=2Ethread-6c9df9=2Egit-d39264656387=2Eyou?=
 =?utf-8?q?r-ad-here=2Ecall-01620841104-ext-2554=40work=2Ehours=3E?=
References: =?utf-8?q?=3Cpatch-1=2Ethread-6c9df9=2Egit-d39264656387=2Eyour?=
 =?utf-8?q?-ad-here=2Ecall-01620841104-ext-2554=40work=2Ehours=3E?=
MIME-Version: 1.0
Message-ID: <162084435147.29796.6211951426659224988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     7176af27a8bf4ab5b5c7a1850459b194a21cf876
Gitweb:        https://git.kernel.org/tip/7176af27a8bf4ab5b5c7a1850459b194a21cf876
Author:        Vasily Gorbik <gor@linux.ibm.com>
AuthorDate:    Wed, 12 May 2021 19:42:10 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 20:25:48 +02:00

objtool: Fix elf_create_undef_symbol() endianness

Currently x86 cross-compilation fails on big endian system with:

  x86_64-cross-ld: init/main.o: invalid string offset 488112128 >= 6229 for section `.strtab'

Mark new ELF data in elf_create_undef_symbol() as symbol, so that libelf
does endianness handling correctly.

Fixes: 2f2f7e47f052 ("objtool: Add elf_create_undef_symbol()")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/patch-1.thread-6c9df9.git-d39264656387.your-ad-here.call-01620841104-ext-2554@work.hours
---
 tools/objtool/elf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d08f5f3..743c2e9 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -762,6 +762,7 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 	data->d_buf = &sym->sym;
 	data->d_size = sizeof(sym->sym);
 	data->d_align = 1;
+	data->d_type = ELF_T_SYM;
 
 	sym->idx = symtab->len / sizeof(sym->sym);
 
