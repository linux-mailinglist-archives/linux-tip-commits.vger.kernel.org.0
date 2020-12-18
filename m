Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B542DE727
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Dec 2020 17:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgLRQDQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Dec 2020 11:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgLRQDQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Dec 2020 11:03:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55F5C0617A7;
        Fri, 18 Dec 2020 08:02:35 -0800 (PST)
Date:   Fri, 18 Dec 2020 16:02:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608307353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFqT7MdMkMPajxa+3jGsjpVqAegoRAPqBlb6GgY5BT0=;
        b=lpOXHJKBTNpLUCxV/M6LtJdlEAGRuUuZBCv+MBVIbUhWFzWmP/am6Qlh9kDCkABuplFHSx
        ryZWjZRrURrDWx3kgO6kyuLr7nq0P5HotEiRDUuroKsoyiNxhuHDKp93H6idb7/f2hsfb3
        pfAgqGDkcBxCt2XljQDBV6feuk6IlASnE/cArBFJqhaQaxiNTTIS5g+FmvtaAfz9LhOUmx
        sxbPKgGo2/QPet5jfNC0pIy2tiUkZauBgFq4Nu4QVpj6Zh4rhWCgVwHMBma4dWBgzsfwCU
        Ag2mUaM4XSpq/RsfNDgTXXXW1vWZtZwHL1lpZVLLs2xoGZ/s/j5aAUdyyvcD1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608307353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFqT7MdMkMPajxa+3jGsjpVqAegoRAPqBlb6GgY5BT0=;
        b=L8uGwYrpljlLfwhseC1NsjVUYwJe4gPdXendgZ7YmciUHPDVLn3ZMEx11gNgDd5prBBFDz
        aJ2J/fG/++wMO1CA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] jump_label/static_call: Add MAINTAINERS
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201216133014.GT3092@hirez.programming.kicks-ass.net>
References: <20201216133014.GT3092@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160830735320.22759.7371044943415400270.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     441fa3409769180df2fd12fcada35441435a120c
Gitweb:        https://git.kernel.org/tip/441fa3409769180df2fd12fcada35441435a120c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Dec 2020 14:19:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 18 Dec 2020 16:53:12 +01:00

jump_label/static_call: Add MAINTAINERS

These files don't appear to have a MAINTAINERS entry and as such
patches miss being seen by people who know this code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Jason Baron <jbaron@akamai.com>
Link: https://lkml.kernel.org/r/20201216133014.GT3092@hirez.programming.kicks-ass.net
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 281de21..be02614 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16675,6 +16675,22 @@ M:	Ion Badulescu <ionut@badula.org>
 S:	Odd Fixes
 F:	drivers/net/ethernet/adaptec/starfire*
 
+STATIC BRANCH/CALL
+M:	Peter Zijlstra <peterz@infradead.org>
+M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Jason Baron <jbaron@akamai.com>
+R:	Steven Rostedt <rostedt@goodmis.org>
+R:	Ard Biesheuvel <ardb@kernel.org>
+S:	Supported
+F:	arch/*/include/asm/jump_label*.h
+F:	arch/*/include/asm/static_call*.h
+F:	arch/*/kernel/jump_label.c
+F:	arch/*/kernel/static_call.c
+F:	include/linux/jump_label*.h
+F:	include/linux/static_call*.h
+F:	kernel/jump_label.c
+F:	kernel/static_call.c
+
 STEC S1220 SKD DRIVER
 M:	Damien Le Moal <Damien.LeMoal@wdc.com>
 L:	linux-block@vger.kernel.org
