Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD09283B95
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Oct 2020 17:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgJEPsd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Oct 2020 11:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgJEPsd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Oct 2020 11:48:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA609C0613CE;
        Mon,  5 Oct 2020 08:48:32 -0700 (PDT)
Date:   Mon, 05 Oct 2020 15:48:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601912909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=X1QsCQ/nqHzEMGRxGzS/ypcU7g5Cvcg1CMBrnKVfsLM=;
        b=sOLa7XIW2nPphWs4j7UUWXLG+JslJABm1XIEGR00agB7EI7wRQNI5ln03URGQi/rkN6udE
        K6oycyBPkulXLyo1xEBdK8nMb4JJ4OhnBZkMKlEzpbqD725sv39emuE5vonOoi8dqjd8Ek
        d7KwDeAspllDUMb3ZgSre21SPRJmdeKw6HPF8p97h8eFX2nveFPmCchSRq6VBtRDwocbeU
        4c+CB8hp7nW6CujpOC3BIHAF8Azt3SLREXntqg1y8Sl+tCZQ4iEI3CSPtHZebp9h7nPfPx
        D2yPJJujzpMNwpq6VKNMghaLXnjLakKDI7bgOz/FvwMTqX8IaxgV4b2kO3o6JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601912909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=X1QsCQ/nqHzEMGRxGzS/ypcU7g5Cvcg1CMBrnKVfsLM=;
        b=wmuLBO9LkwaN49i49FyK7JZyFq42hKty6E/QhTlLIBVjVqSckdQWgZ1aW4iu/ydgcmmklf
        nJSwR3VGUjjIUyDQ==
From:   "tip-bot2 for Jann Horn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Permit __kasan_check_{read,write} under UACCESS
Cc:     Jann Horn <jannh@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160191290839.7002.472467128792746457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b0b8e56b82c06b3bb6e5fb66d0e9c9c3fd3ce555
Gitweb:        https://git.kernel.org/tip/b0b8e56b82c06b3bb6e5fb66d0e9c9c3fd3=
ce555
Author:        Jann Horn <jannh@google.com>
AuthorDate:    Tue, 29 Sep 2020 00:49:16 +02:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Fri, 02 Oct 2020 09:28:08 -05:00

objtool: Permit __kasan_check_{read,write} under UACCESS

Building linux-next with JUMP_LABEL=3Dn and KASAN=3Dy, I got this objtool
warning:

arch/x86/lib/copy_mc.o: warning: objtool: copy_mc_to_user()+0x22: call to
__kasan_check_read() with UACCESS enabled

What happens here is that copy_mc_to_user() branches on a static key in a
UACCESS region:

=C2=A0 =C2=A0 =C2=A0 =C2=A0 __uaccess_begin();
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (static_branch_unlikely(&copy_mc_fragile_key))
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D copy_mc_fragi=
le(to, from, len);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D copy_mc_generic(to, from, len);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __uaccess_end();

and the !CONFIG_JUMP_LABEL version of static_branch_unlikely() uses
static_key_enabled(), which uses static_key_count(), which uses
atomic_read(), which calls instrument_atomic_read(), which uses
kasan_check_read(), which is __kasan_check_read().

Let's permit these KASAN helpers in UACCESS regions - static keys should
probably work under UACCESS, I think.

PeterZ adds:

  It's not a matter of permitting, it's a matter of being safe and
  correct. In this case it is, because it's a thin wrapper around
  check_memory_region() which was already marked safe.

  check_memory_region() is correct because the only thing it ends up
  calling is kasa_report() and that is also marked safe because that is
  annotated with user_access_save/restore() before it does anything else.

  On top of that, all of KASAN is noinstr, so nothing in here will end up
  in tracing and/or call schedule() before the user_access_save().

Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2df9f76..3d14134 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -583,6 +583,8 @@ static const char *uaccess_safe_builtin[] =3D {
 	"__asan_store4_noabort",
 	"__asan_store8_noabort",
 	"__asan_store16_noabort",
+	"__kasan_check_read",
+	"__kasan_check_write",
 	/* KASAN in-line */
 	"__asan_report_load_n_noabort",
 	"__asan_report_load1_noabort",
