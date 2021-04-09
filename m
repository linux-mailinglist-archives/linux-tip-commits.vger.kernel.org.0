Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE4359D58
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhDILap (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 07:30:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50118 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDILap (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 07:30:45 -0400
Date:   Fri, 09 Apr 2021 11:30:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617967831;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bwual4sIAnoZe8dE2uFyqX/II+fAPUVbohLGfbgniEo=;
        b=M5AInw0qDBFXpKKGKyPWT9ZIbHqhbfiRgVrvi91xvxxk2qcIMDPD99Hpc2BzaU4X7Zfphe
        Smnk4N9pdoszESqMCF4vKM/kWgsrklEqCIbGeUTqZbVdjJg0jAHBFT3BXGaIM8bgsx83pp
        G1CEyWsU+nqMDXGhWTDHays4JkcAGz4mytDAj7qv0jcqFe5Y1j5DIQA9IQ7QC5ZUMhZyp+
        zTEcvTseo1h0QSuF+N4Aw29BAa+y0NN8mXnbFZgfwJCmQDJJ37IDv2t0FF8Zen/E3pviUC
        lFkHLYEagQrbB/xzYWqr/hMnlqfX0McxXyK5JOlAGq8La2PK3jIgIwRlyA/MjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617967831;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bwual4sIAnoZe8dE2uFyqX/II+fAPUVbohLGfbgniEo=;
        b=HPBtZKyVOg6eozoePTKuM3DL7P4HpHgkmH5e0HNJOdPqov8ln2kC45g/wN5qIpcgxvPeh4
        i0abe2fMcBOm2SDw==
From:   "tip-bot2 for Matthieu Baerts" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] static_call: Fix unused variable warn w/o MODULE
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326105023.2058860-1-matthieu.baerts@tessares.net>
References: <20210326105023.2058860-1-matthieu.baerts@tessares.net>
MIME-Version: 1.0
Message-ID: <161796783118.29796.15597297301390026189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7d95f22798ecea513f37b792b39fec4bcf20fec3
Gitweb:        https://git.kernel.org/tip/7d95f22798ecea513f37b792b39fec4bcf2=
0fec3
Author:        Matthieu Baerts <matthieu.baerts@tessares.net>
AuthorDate:    Fri, 26 Mar 2021 11:50:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Apr 2021 13:22:12 +02:00

static_call: Fix unused variable warn w/o MODULE

Here is the warning converted as error and reported by GCC:

  kernel/static_call.c: In function =E2=80=98__static_call_update=E2=80=99:
  kernel/static_call.c:153:18: error: unused variable =E2=80=98mod=E2=80=99 [=
-Werror=3Dunused-variable]
    153 |   struct module *mod =3D site_mod->mod;
        |                  ^~~
  cc1: all warnings being treated as errors
  make[1]: *** [scripts/Makefile.build:271: kernel/static_call.o] Error 1

This is simply because since recently, we no longer use 'mod' variable
elsewhere if MODULE is unset.

When using 'make tinyconfig' to generate the default kconfig, MODULE is
unset.

There are different ways to fix this warning. Here I tried to minimised
the number of modified lines and not add more #ifdef. We could also move
the declaration of the 'mod' variable inside the if-statement or
directly use site_mod->mod.

Fixes: 698bacefe993 ("static_call: Align static_call_is_init() patching condi=
tion")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210326105023.2058860-1-matthieu.baerts@tess=
ares.net
---
 kernel/static_call.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index 2c5950b..723fcc9 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -165,13 +165,13 @@ void __static_call_update(struct static_call_key *key, =
void *tramp, void *func)
=20
 		stop =3D __stop_static_call_sites;
=20
-#ifdef CONFIG_MODULES
 		if (mod) {
+#ifdef CONFIG_MODULES
 			stop =3D mod->static_call_sites +
 			       mod->num_static_call_sites;
 			init =3D mod->state =3D=3D MODULE_STATE_COMING;
-		}
 #endif
+		}
=20
 		for (site =3D site_mod->sites;
 		     site < stop && static_call_key(site) =3D=3D key; site++) {
