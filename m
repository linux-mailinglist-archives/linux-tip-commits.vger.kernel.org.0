Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7197837EDD6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 00:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354110AbhELUz1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 16:55:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53358 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359013AbhELSvS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 14:51:18 -0400
Date:   Wed, 12 May 2021 18:50:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620845408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EAuL4nmFY+LmjTtabIjR72OWQw2n26sliznKKiS66yc=;
        b=BHwn0Qib9w5XMCa1NzUC3FFq59qR0BDY5AIyQWOmwYCR4WDqIO0YvRmH05vdj6vdX2vqSj
        vvjvoSmJ5jqDSla8TMNhaW4zJFkaXYvNc+v4blLxnxOtG7tu34sxqPAa//SALoP806vQ5s
        2K+m1cPXEGP32XGKRr8qz5SmZft4Wvb8wIe9TDdT0ssK5IQ9Sn+1eV17WvD5hCcB/3CJxg
        9Za7R69yvlbQjF1m9Z8ZDyswJtbIZljytwVkzkjtgs/wYnWKX+cCjj3l+4qHeGwnl+272h
        23n24QhrI00MEexMeO+UOmg7rBa7qJa+XEKf5G+LmaKWwWxmZPuk7AaiDcn3qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620845408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EAuL4nmFY+LmjTtabIjR72OWQw2n26sliznKKiS66yc=;
        b=wK81E32W29sUNAmWZq9d0dk3uBninYVITYdDkQQoXApMdh45wqmnSTMq1XFo7Ug+FyP5sm
        x2m1bN8AiTQeTeAw==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] selftests: futex: Correctly include headers dirs
Cc:     andrealmeid@collabora.com, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210427135328.11013-2-andrealmeid@collabora.com>
References: <20210427135328.11013-2-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <162084540802.29796.2191659704209594178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c7d84e7ff5a651d186a6ec41361c4f07acc2fb9c
Gitweb:        https://git.kernel.org/tip/c7d84e7ff5a651d186a6ec41361c4f07acc=
2fb9c
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Tue, 27 Apr 2021 10:53:27 -03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 20:44:58 +02:00

selftests: futex: Correctly include headers dirs

When building selftests, the build system will install uapi linux
headers at usr/include in kernel source's root directory. When building
with a different output folder, the headers will be installed at
kselftests/usr/include.

Add both paths so we can build the tests using up-to-date headers.

Currently, this is uncommon to happen since it's rare to find a
build system with an outdated futex header, but it happens
when testing new futex operations.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210427135328.11013-2-andrealmeid@collabora.=
com
---
 tools/testing/selftests/futex/functional/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testin=
g/selftests/futex/functional/Makefile
index 2320782..1d2b3b2 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-INCLUDES :=3D -I../include -I../../
+INCLUDES :=3D -I../include -I../../ -I../../../../../usr/include/ \
+	-I$(KBUILD_OUTPUT)/kselftest/usr/include
 CFLAGS :=3D $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES)
 LDLIBS :=3D -lpthread -lrt
=20
