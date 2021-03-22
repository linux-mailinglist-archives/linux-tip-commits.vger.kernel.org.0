Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E63B3452FF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 00:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCVXae (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Mar 2021 19:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhCVXa1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Mar 2021 19:30:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF30FC061574;
        Mon, 22 Mar 2021 16:30:26 -0700 (PDT)
Date:   Mon, 22 Mar 2021 23:30:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616455824;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pg/9hA88TYVlYNQN94IwUVdPFUBoQ5ovEN4chzrcyJg=;
        b=GwXh3iAjANWfXkN1PYnsHnZfSIyPnmxVjCfnxQGvEEGg/yrGJUP+2jhcjC8Mipmtl46u/c
        NyPnuuWjyuWfd7FA7y/dttml5LhWv964wHvm6T8yrT71BGNp1a+fAMi03ntfqsPxUrO4N8
        yqHeMmwT8e+oO/7y4HcDCMK06+eABzS3uezMNw0nKEQJsGoXSI1//XsXMmwIonlCcj+bga
        YWbQj0ci6DVdnhHeuyy8iRzA/EKWilW3zK9GGT/uM0ecwXffiMy60Xe/ma/wvoYCltMR8K
        JrffvM42ugWmAo1PYLyQWc2W4lCOa84kTZD1hiMmFmv3xBKv+VpRp5rnQPIrEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616455824;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pg/9hA88TYVlYNQN94IwUVdPFUBoQ5ovEN4chzrcyJg=;
        b=nsw+fFC7uR74FyWsrtQdNq2sZgxOt5i6pVUdFI2vFtFDZ4GJWKean3DYB2Z8bX7o4GCCSi
        euV0R0IDa3Omv0BQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Avoid gcc-11 -Wstringop-overread warning
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Sebor <msebor@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210322160253.4032422-2-arnd@kernel.org>
References: <20210322160253.4032422-2-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161645582353.398.15659537089500067394.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     e14cfb3bdd0f82147d09e9f46bedda6302f28ee1
Gitweb:        https://git.kernel.org/tip/e14cfb3bdd0f82147d09e9f46bedda6302f=
28ee1
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 22 Mar 2021 17:02:39 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 23 Mar 2021 00:16:25 +01:00

x86/boot/compressed: Avoid gcc-11 -Wstringop-overread warning

GCC gets confused by the comparison of a pointer to an integer literal,
with the assumption that this is an offset from a NULL pointer and that
dereferencing it is invalid:

  In file included from arch/x86/boot/compressed/misc.c:18:
  In function =E2=80=98parse_elf=E2=80=99,
      inlined from =E2=80=98extract_kernel=E2=80=99 at arch/x86/boot/compress=
ed/misc.c:442:2:
  arch/x86/boot/compressed/../string.h:15:23: error: =E2=80=98__builtin_memcp=
y=E2=80=99 reading 64 bytes from a region of size 0 [-Werror=3Dstringop-overr=
ead]
     15 | #define memcpy(d,s,l) __builtin_memcpy(d,s,l)
        |                       ^~~~~~~~~~~~~~~~~~~~~~~
  arch/x86/boot/compressed/misc.c:283:9: note: in expansion of macro =E2=80=
=98memcpy=E2=80=99
    283 |         memcpy(&ehdr, output, sizeof(ehdr));
        |         ^~~~~~

I could not find any good workaround for this, but as this is only
a warning for a failure during early boot, removing the line entirely
works around the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Sebor <msebor@gmail.com>
Link: https://lore.kernel.org/r/20210322160253.4032422-2-arnd@kernel.org
---
 arch/x86/boot/compressed/misc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 267e7f9..1945b8a 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -430,8 +430,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, me=
mptr heap,
 		error("Destination address too large");
 #endif
 #ifndef CONFIG_RELOCATABLE
-	if ((unsigned long)output !=3D LOAD_PHYSICAL_ADDR)
-		error("Destination address does not match LOAD_PHYSICAL_ADDR");
 	if (virt_addr !=3D LOAD_PHYSICAL_ADDR)
 		error("Destination virtual address changed when not relocatable");
 #endif
