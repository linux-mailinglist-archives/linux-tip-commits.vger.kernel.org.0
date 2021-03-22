Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C39A3452FE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 00:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhCVXae (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Mar 2021 19:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhCVXa2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Mar 2021 19:30:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A66DC061762;
        Mon, 22 Mar 2021 16:30:27 -0700 (PDT)
Date:   Mon, 22 Mar 2021 23:30:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616455825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cL+USnSp7/jUTbUTtmOBgwaPUByaoo+xUtU5DF6UQ1E=;
        b=cnk2KJABK9q/YAwrMNP/27vk3vZ2ycsDv1jqwHLxy/0jrTYXnEN1CPnab9cnFn1dsyqF4Y
        OYoyU0LDnDbFyYoKmFlTwWRzxrIml1IkH6LE1epg16J72bDldDuYj4g9v/f/vkM5yZZpHU
        MuBHrPs8b6jjpztPTNweF789tJ7vX464HRPkVkV1xV8wIdnMkMbtFrLeFq59a3qC990L8h
        cpZIUq8KmLNXz2RrmFHiey4rbZFhX44NEUkbStPaP36dc/KtJVvoZebmKWjRpeT9Y3DgJS
        57MGlu9NEXAPu0mOfYK/YTQbYYKJb+pdxIImtMzhqwIe8yKvFCFGKuCAYLgk6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616455825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cL+USnSp7/jUTbUTtmOBgwaPUByaoo+xUtU5DF6UQ1E=;
        b=bLllpBhtXPsKhSUzU5WcetIHboLn49VGJIcIPhI7bWa30VYm85TsMC3vpqbhxgVSbjqfZ7
        CO29p3FtTT6vf5CA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/fpu/math-emu: Fix function cast warning
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210322214824.974323-1-arnd@kernel.org>
References: <20210322214824.974323-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161645582500.398.11005961715450054913.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     279d56abc67ed7568168cb31bf1c7d735efc89a7
Gitweb:        https://git.kernel.org/tip/279d56abc67ed7568168cb31bf1c7d735ef=
c89a7
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 22 Mar 2021 22:48:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 23 Mar 2021 00:08:02 +01:00

x86/fpu/math-emu: Fix function cast warning

Building with 'make W=3D1', gcc points out that casting between
incompatible function types can be dangerous:

  arch/x86/math-emu/fpu_trig.c:1638:60: error: cast between incompatible func=
tion types from =E2=80=98int (*)(FPU_REG *, u_char)=E2=80=99 {aka =E2=80=98in=
t (*)(struct fpu__reg *, unsigned char)=E2=80=99} to =E2=80=98void (*)(FPU_RE=
G *, u_char)=E2=80=99 {aka =E2=80=98void (*)(struct fpu__reg *, unsigned char=
)=E2=80=99} [-Werror=3Dcast-function-type]
   1638 |         fprem, fyl2xp1, fsqrt_, fsincos, frndint_, fscale, (FUNC_ST=
0) fsin, fcos
        |                                                            ^

This one seems harmless, but it is easy enough to work around it by
adding an intermediate function that adjusts the return type.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210322214824.974323-1-arnd@kernel.org
---
 arch/x86/math-emu/fpu_trig.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/math-emu/fpu_trig.c b/arch/x86/math-emu/fpu_trig.c
index 4a98878..990d847 100644
--- a/arch/x86/math-emu/fpu_trig.c
+++ b/arch/x86/math-emu/fpu_trig.c
@@ -547,7 +547,7 @@ static void frndint_(FPU_REG *st0_ptr, u_char st0_tag)
 		single_arg_error(st0_ptr, st0_tag);
 }
=20
-static int fsin(FPU_REG *st0_ptr, u_char tag)
+static int f_sin(FPU_REG *st0_ptr, u_char tag)
 {
 	u_char arg_sign =3D getsign(st0_ptr);
=20
@@ -608,6 +608,11 @@ static int fsin(FPU_REG *st0_ptr, u_char tag)
 	}
 }
=20
+static void fsin(FPU_REG *st0_ptr, u_char tag)
+{
+	f_sin(st0_ptr, tag);
+}
+
 static int f_cos(FPU_REG *st0_ptr, u_char tag)
 {
 	u_char st0_sign;
@@ -724,7 +729,7 @@ static void fsincos(FPU_REG *st0_ptr, u_char st0_tag)
 	}
=20
 	reg_copy(st0_ptr, &arg);
-	if (!fsin(st0_ptr, st0_tag)) {
+	if (!f_sin(st0_ptr, st0_tag)) {
 		push();
 		FPU_copy_to_reg0(&arg, st0_tag);
 		f_cos(&st(0), st0_tag);
@@ -1635,7 +1640,7 @@ void FPU_triga(void)
 }
=20
 static FUNC_ST0 const trig_table_b[] =3D {
-	fprem, fyl2xp1, fsqrt_, fsincos, frndint_, fscale, (FUNC_ST0) fsin, fcos
+	fprem, fyl2xp1, fsqrt_, fsincos, frndint_, fscale, fsin, fcos
 };
=20
 void FPU_trigb(void)
