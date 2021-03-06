Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7168C32FA50
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhCFLzS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCFLyh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:54:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0704C061760;
        Sat,  6 Mar 2021 03:54:36 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSDv08rmaJkNhfkdGih9mCJWB3UWvq+wDxPY0wYQsBU=;
        b=c7lP1iCGDUOqfDePAgWnzvextgxyzUlShJw5LGeXwIyPY8NCbo9CycfSvcme4og0HKoue/
        duFiOIMJ8qBCP8tdNvTZeyNupDII2KO+h7DIcz84yH/55p1uoEugWunhdkNib4WfK3qoz/
        w8qU2fhWmNjPV57ljzKcpWyTe1uXgop8VVKTZAahdSSbxQAghdFvQ6Jihd2b+VvjLH6WdT
        Cbah9qbQX+eY/QbYAuUAkS//2GY5fp9Qlfk9MNsb694yOiCSBUl6eRMWhPHTe1wBfmrRK9
        JLGUClhQ1ZYZHtO4Wne44BGqLYW7OAXcxfPZk+mvJZV8efLO2WSOk3GQBXJ7Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSDv08rmaJkNhfkdGih9mCJWB3UWvq+wDxPY0wYQsBU=;
        b=Fcz23MRBv4DCbwYlNz5UkM9nkIuUsUMUCAHVqm4q/yVtPyqZA7ojVf3Ca7jeNZB0K+u4Wu
        m5nQ/O9/wvT5MxBg==
From:   "tip-bot2 for Jason Gerecke" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/jump_label: Mark arguments as const to
 satisfy asm constraints
Cc:     Jason Gerecke <jason.gerecke@wacom.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211214848.536626-1-jason.gerecke@wacom.com>
References: <20210211214848.536626-1-jason.gerecke@wacom.com>
MIME-Version: 1.0
Message-ID: <161503167499.398.2614748467573329233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     864b435514b286c0be2a38a02f487aa28d990ef8
Gitweb:        https://git.kernel.org/tip/864b435514b286c0be2a38a02f487aa28d9=
90ef8
Author:        Jason Gerecke <killertofu@gmail.com>
AuthorDate:    Thu, 11 Feb 2021 13:48:48 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:51:00 +01:00

x86/jump_label: Mark arguments as const to satisfy asm constraints

When compiling an external kernel module with `-O0` or `-O1`, the following
compile error may be reported:

    ./arch/x86/include/asm/jump_label.h:25:2: error: impossible constraint in=
 =E2=80=98asm=E2=80=99
       25 |  asm_volatile_goto("1:"
          |  ^~~~~~~~~~~~~~~~~

It appears that these lower optimization levels prevent GCC from detecting
that the key/branch arguments can be treated as constants and used as
immediate operands. To work around this, explicitly add the `const` label.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20210211214848.536626-1-jason.gerecke@wacom.c=
om
---
 arch/x86/include/asm/jump_label.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_la=
bel.h
index 06c3cc2..7f20066 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -20,7 +20,7 @@
 #include <linux/stringify.h>
 #include <linux/types.h>
=20
-static __always_inline bool arch_static_branch(struct static_key *key, bool =
branch)
+static __always_inline bool arch_static_branch(struct static_key * const key=
, const bool branch)
 {
 	asm_volatile_goto("1:"
 		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
@@ -36,7 +36,7 @@ l_yes:
 	return true;
 }
=20
-static __always_inline bool arch_static_branch_jump(struct static_key *key, =
bool branch)
+static __always_inline bool arch_static_branch_jump(struct static_key * cons=
t key, const bool branch)
 {
 	asm_volatile_goto("1:"
 		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
