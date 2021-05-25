Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50C339046C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 17:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhEYPC0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 11:02:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48806 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbhEYPCY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 11:02:24 -0400
Date:   Tue, 25 May 2021 15:00:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621954853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZArEFYdfnyU570FJgtAcCeWwQ2SADTctmJdgtQI5l4=;
        b=OOF+3YotxvS06dOZZbvrrgmVDWnL788Aaadidn/u822qhqtLE28ooV00Xs49o5kk41QRER
        5RqwmCWqTRu2gFzRGsVUmcmwgU9hNYdzPoX3Fa7ldbPuXiCNDNqmbWTHC2aTwERS4UsJRR
        i5luwKQDAlPEBwPMMjzhjQX0AFqzCHyShJ0WUhqFeOvpEQuwfhJ8UudQKt8SN79lddKdqu
        e0032W/wPLPGwZt7eFIKcEMQyW6yE6Uu1fGEoo56zvhVC1PymQDzfRXTZ+sqixYmXRs0Ys
        csDZ4eMWlowHEuGcalrJF+rc18ds1E4E9KKhEuW5XGXzCWDu8e/Ztm/UivAhNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621954853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZArEFYdfnyU570FJgtAcCeWwQ2SADTctmJdgtQI5l4=;
        b=qrRszZ4AVvQoehJswqsqKyoi+VCZ1q5i0DpaRcmNnH6p9Afk5B6MKrTZSgC3f7exCWhT/A
        fcLPlsYN7Hp/+rBw==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/syscalls: Clear 'offset' and 'prefix' in case
 they are set in env
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525115420.679416-1-masahiroy@kernel.org>
References: <20210525115420.679416-1-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <162195485231.29796.8929798189969449838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     1eb8a49836949a77c4f7d738786719e7fde0c333
Gitweb:        https://git.kernel.org/tip/1eb8a49836949a77c4f7d738786719e7fde0c333
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Tue, 25 May 2021 20:54:20 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 May 2021 16:59:23 +02:00

x86/syscalls: Clear 'offset' and 'prefix' in case they are set in env

If the environment variable 'prefix' is set on the build host, it is
wrongly used as syscall macro prefixes.

  $ export prefix=/usr
  $ make -s defconfig all
  In file included from ./arch/x86/include/asm/unistd.h:20,
                   from <stdin>:2:
  ./arch/x86/include/generated/uapi/asm/unistd_64.h:4:9: warning: missing whitespace after the macro name
      4 | #define __NR_/usrread 0
        |         ^~~~~

arch/x86/entry/syscalls/Makefile should clear 'offset' and 'prefix'.

Fixes: 3cba325b358f ("x86/syscalls: Switch to generic syscallhdr.sh")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210525115420.679416-1-masahiroy@kernel.org

---
 arch/x86/entry/syscalls/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/entry/syscalls/Makefile b/arch/x86/entry/syscalls/Makefile
index 8eb014b..5b3efed 100644
--- a/arch/x86/entry/syscalls/Makefile
+++ b/arch/x86/entry/syscalls/Makefile
@@ -11,6 +11,8 @@ syscall64 := $(src)/syscall_64.tbl
 
 syshdr := $(srctree)/scripts/syscallhdr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
+offset :=
+prefix :=
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --abis $(abis) --emit-nr \
