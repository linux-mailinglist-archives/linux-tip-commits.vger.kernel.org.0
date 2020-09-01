Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6A7258DB2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Sep 2020 13:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgIALxh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Sep 2020 07:53:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgIALtd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:33 -0400
Date:   Tue, 01 Sep 2020 11:48:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9m4anUz0N5vIPvPFBVZIXdNWULcKGTjX1fUebtN+IY=;
        b=q5v+iQL4YC4pEPHqE403FWVC5itrBNdJNsrGSVLxYw7J/jQzUnKbRoRsK4wyNTBGWV6NgJ
        iCcnfUCIAlESm8iwwX+rYsAUZeh9cWHjcACz7ga8w9rMtn9MjqtRsqygCKDotYjy+2sPjc
        jxRcdPdk6/mL9calWkuGxQBw/g+Nl7ig36c7gdt82Ep2vfgNZ4ho+Ic1XVNHJILKEthy27
        8USKxXGygE/T7BDJrf6Yk3twWiFRdiQcA4zKNiEzQN0xL6BZa9N8MvcuZID3QaysjX8nTL
        JLXgv1ovmr+IkeYgmbyiTPoEzAFsckSUjMGUp9rhREUlI0Ee8nCvIv7K6cC4Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9m4anUz0N5vIPvPFBVZIXdNWULcKGTjX1fUebtN+IY=;
        b=4npmoOZTR/YdWg7xfYb/vmcvQ+6DnJQmHlud3k6U5qVmlqkOYe3PWjtSyvRRap8RS16+sq
        uN8wMYd27HX+rbCg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] compiler.h: Make __ADDRESSABLE() symbol truly unique
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135804.564436253@infradead.org>
References: <20200818135804.564436253@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088740.20229.7656713937908382909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     563a02b0c9704f69c0364befedd451f57fe88092
Gitweb:        https://git.kernel.org/tip/563a02b0c9704f69c0364befedd451f57fe88092
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Tue, 18 Aug 2020 15:57:40 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:04 +02:00

compiler.h: Make __ADDRESSABLE() symbol truly unique

The __ADDRESSABLE() macro uses the __LINE__ macro to create a temporary
symbol which has a unique name.  However, if the macro is used multiple
times from within another macro, the line number will always be the
same, resulting in duplicate symbols.

Make the temporary symbols truly unique by using __UNIQUE_ID instead of
__LINE__.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Link: https://lore.kernel.org/r/20200818135804.564436253@infradead.org
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 6810d80..92ef163 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -207,7 +207,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  */
 #define __ADDRESSABLE(sym) \
 	static void * __section(.discard.addressable) __used \
-		__PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
+		__UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
 
 /**
  * offset_to_ptr - convert a relative memory offset to an absolute pointer
