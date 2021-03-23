Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D0E34631A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 16:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhCWPjK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 11:39:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34016 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhCWPio (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 11:38:44 -0400
Date:   Tue, 23 Mar 2021 15:38:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616513923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8xwilMXz7AKKY64cPLxMUQ/aMptcJkwWwUCAgM8fDo=;
        b=Ab6AmUH8z/UOcmflYsMNwFt/S0UmRunL83HsLLQZ/r1aOUm3LveVs2zW+sl1neg3jbnHYF
        PXW4hyr9MssrycHe4D6BOtFRvmk1yzPSfKR5tFs7ZC9Qx0+AQPNO520zpW6/BWI/f9tGKX
        A74QnvmaLArQwst5Rs4okWNvRo7/GKwG+uCxD7Dd9zR91npRyXvCM8ryokX/75m7Y6YKNL
        d4jnBDh7qvaVTw5OeeswnARwhmMWd+5j/AHrHYVCnZ6xU2jSNkFxDujJoPbKHoHFsim/5v
        2hNFxt/v4IDrbn+YH62cb31or69rQLf/UGVUD4vQA7h+iWCYvkst3wOjHbh3Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616513923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8xwilMXz7AKKY64cPLxMUQ/aMptcJkwWwUCAgM8fDo=;
        b=5hRVJqQa2l90WZXgUX/4uhAowlC+UkyFnfVyqrT8V3zwz4TkVo6GQzQUotBioE6wqQ1shR
        eNaHxCrIOhbWvVDA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/build: Turn off -fcf-protection for realmode targets
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210323124846.1584944-1-arnd@kernel.org>
References: <20210323124846.1584944-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161651392283.398.2424033132680458201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9fcb51c14da2953de585c5c6e50697b8a6e91a7b
Gitweb:        https://git.kernel.org/tip/9fcb51c14da2953de585c5c6e50697b8a6e=
91a7b
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 23 Mar 2021 13:48:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 23 Mar 2021 16:36:01 +01:00

x86/build: Turn off -fcf-protection for realmode targets

The new Ubuntu GCC packages turn on -fcf-protection globally,
which causes a build failure in the x86 realmode code:

  cc1: error: =E2=80=98-fcf-protection=E2=80=99 is not compatible with this t=
arget

Turn it off explicitly on compilers that understand this option.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210323124846.1584944-1-arnd@kernel.org
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 2d6d5a2..9a85eae 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -27,7 +27,7 @@ endif
 REALMODE_CFLAGS	:=3D -m16 -g -Os -DDISABLE_BRANCH_PROFILING \
 		   -Wall -Wstrict-prototypes -march=3Di386 -mregparm=3D3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
-		   -mno-mmx -mno-sse
+		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=3Dnone)
=20
 REALMODE_CFLAGS +=3D -ffreestanding
 REALMODE_CFLAGS +=3D -fno-stack-protector
