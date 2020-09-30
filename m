Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC8727E04F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgI3F16 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgI3F1y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:27:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C0EC061755;
        Tue, 29 Sep 2020 22:27:54 -0700 (PDT)
Date:   Wed, 30 Sep 2020 05:27:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601443673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jf9Hur7rJehZGjdx5eGI1b5g3kuWC6R+KNmrplfckdg=;
        b=LrVb1psI7bsZnG3AH0HCXcrn3e2ykVGRz2M+a01oYgAws4HN3UNwga7yKmg3IQShGK/4SS
        EttrhcXCeYkMUuVQxa+2Y2x0iz/b1j6hdwGRjbDZT/aGgbtmAo+FwpVwz0j3eYRHhUrk+K
        r6kb5bN16hyagYT7R7oOR/hHhB8MgDKZftDjjt9kSmggztKJjo/C1zAFEej058daOYR1PV
        0VRnfcvtp2/orkk55nAI1Vo4RWECzOxwEmM6D7U5Gf406NkAGguDaF4zDAAZxzJoEtNmhx
        YNyUC9AvUD+54meC231CT+LQdfXIsjfX0BD0kU5oGd10ke5L/eruQMfOKrts3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601443673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jf9Hur7rJehZGjdx5eGI1b5g3kuWC6R+KNmrplfckdg=;
        b=p13YUNnxtGLhqAkZxgsS+SZoRqkOfQnDQpjmWGxlZg7GrBX4eHq8rinrPVN0vOGXqS4OMo
        B9QH9zh+i6bEk/Cw==
From:   "tip-bot2 for Tian Tao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: Fix missing-prototypes in string.c
Cc:     Tian Tao <tiantao6@hisilicon.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600653203-57909-1-git-send-email-tiantao6@hisilicon.com>
References: <1600653203-57909-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Message-ID: <160144367249.7002.1438777961036354231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     aad0f3d693bbb356b9478879ecd245d4f7a2beb0
Gitweb:        https://git.kernel.org/tip/aad0f3d693bbb356b9478879ecd245d4f7a=
2beb0
Author:        Tian Tao <tiantao6@hisilicon.com>
AuthorDate:    Mon, 21 Sep 2020 09:53:23 +08:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 25 Sep 2020 23:29:04 +02:00

efi/libstub: Fix missing-prototypes in string.c

Fix the following warnings.
drivers/firmware/efi/libstub/string.c:83:20: warning: no previous
prototype for =E2=80=98simple_strtoull=E2=80=99 [-Wmissing-prototypes]
drivers/firmware/efi/libstub/string.c:108:6: warning: no previous
prototype for =E2=80=98simple_strtol=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Link: https://lore.kernel.org/r/1600653203-57909-1-git-send-email-tiantao6@hi=
silicon.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/string.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/string.c b/drivers/firmware/efi/lib=
stub/string.c
index 1ac2f87..5d13e43 100644
--- a/drivers/firmware/efi/libstub/string.c
+++ b/drivers/firmware/efi/libstub/string.c
@@ -7,6 +7,7 @@
  */
=20
 #include <linux/ctype.h>
+#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/string.h>
=20
