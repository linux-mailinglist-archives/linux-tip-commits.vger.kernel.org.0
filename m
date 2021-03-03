Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CCA32C77D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355612AbhCDAcH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351531AbhCCIQq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 03:16:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B05C061356;
        Wed,  3 Mar 2021 00:16:01 -0800 (PST)
Date:   Wed, 03 Mar 2021 08:15:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614759360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWhV/aM7cHTx5ZTQ71/RJ8WdQmdRB7WJv+92VXqEVEk=;
        b=MeJZkiluH46DY+UERW7+8yNVlKzo9BI6Xp+h4j7Rv9wk468lBXeakHL4dMw90rR1uV/A8d
        rugTuDKKVWoOOvchksKyPneB9FpMsmVuwzZHCvqyVPjnSRxbGgfwnE+CmBtCCAcVTnKpxo
        s0ri5yCT0j7Z3ip5W/cECDEiGVCrYec6QixXJEq1UoGHNOUbmZ8Kt2Bq6kBk9oXdiR7s6Q
        OTrYxDfS92+p2Tf+okgFXfPwk19JP+R0wsO8ziWlTu2ARC8usxF8NQJYU3xa/YSXeRUoGM
        dKzXUBioQdE4Rq+3lAuA2AK7qXMeAjkIFmKIQOoqfZ/jAofSOrweM7nT2XLI6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614759360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWhV/aM7cHTx5ZTQ71/RJ8WdQmdRB7WJv+92VXqEVEk=;
        b=HCxlKJjESpVRdmZpu8Fe2Cw2U7nUFHUJmGg8OABQpLMSaKtCtO5pk1l9UwV0aqEwfC6q8H
        BgYdpYBtiQj1BfDA==
From:   "tip-bot2 for Jason Gerecke" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/jump_label: Mark arguments as const to
 satisfy asm constraints
Cc:     Jason Gerecke <jason.gerecke@wacom.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211214848.536626-1-jason.gerecke@wacom.com>
References: <20210211214848.536626-1-jason.gerecke@wacom.com>
MIME-Version: 1.0
Message-ID: <161475935972.20312.14663258597445798760.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     566a9522381495d27b596ee3bdc9578ba02a895d
Gitweb:        https://git.kernel.org/tip/566a9522381495d27b596ee3bdc9578ba02=
a895d
Author:        Jason Gerecke <killertofu@gmail.com>
AuthorDate:    Thu, 11 Feb 2021 13:48:48 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 02 Mar 2021 15:06:34 +01:00

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
