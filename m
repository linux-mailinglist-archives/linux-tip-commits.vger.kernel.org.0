Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A091C35AD28
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Apr 2021 14:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhDJMCV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 10 Apr 2021 08:02:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56316 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhDJMCV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 10 Apr 2021 08:02:21 -0400
Date:   Sat, 10 Apr 2021 12:02:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618056125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1T/Y7QFWKNq4nSX24N1lPYPb7RxrPrrcq+fFSziO5Q=;
        b=qEYHMXpSYJWev6Z3n8Ek677qBaLaHoyO6F+InhTE9JaRT3Bpd/EY+3L5krxfamRZp6+kQk
        Of9F6AXUF9gkAdVbQBhYef2+xjT43ysknJQVwNl15pX0wjww7w2vxG+2vG6ucu6d4shbos
        PnRmzd6Nr/dDIsfGVt2lQTL/6KxcsPyK3axQYNFaCGEdcVjhK4eNOLPseOU11c6cGWytPE
        UeCa7s2GNcTN3Kck+/u+k79rUnAl6tQ7WnhST95SNYQMnAYJi/DO1nIEnhGSqqFy9/UUpN
        6PAFxkNnUQiBgc08htx0NMXr5FbdxO0M72xr50eXxbWrhfeCSVOVUDsKpXET3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618056125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1T/Y7QFWKNq4nSX24N1lPYPb7RxrPrrcq+fFSziO5Q=;
        b=uKlpdnWhHHJwPWv9OVM5w7n2ZCRg3PPHhD6oaljZTCo/OYTrKfr+BkCoafXrU4JEcedOOQ
        Rys5GHeVBsQCsMBQ==
From:   "tip-bot2 for Aditya Srivastava" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/platform/intel/quark: Fix incorrect
 kernel-doc comment syntax in files
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210330213022.28769-1-yashsri421@gmail.com>
References: <20210330213022.28769-1-yashsri421@gmail.com>
MIME-Version: 1.0
Message-ID: <161805612484.29796.17285965963701960462.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0d6c8e1e246586b81cb4e6ab1a93a6d4a08a0cf9
Gitweb:        https://git.kernel.org/tip/0d6c8e1e246586b81cb4e6ab1a93a6d4a08a0cf9
Author:        Aditya Srivastava <yashsri421@gmail.com>
AuthorDate:    Wed, 31 Mar 2021 03:00:22 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 10 Apr 2021 13:59:25 +02:00

x86/platform/intel/quark: Fix incorrect kernel-doc comment syntax in files

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
There are certain files in arch/x86/platform/intel-quark, which follow this
syntax, but the content inside does not comply with kernel-doc.
Such lines were probably not meant for kernel-doc parsing, but are parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warnings from kernel-doc.

E.g., presence of kernel-doc like comment in the header lines for
arch/x86/platform/intel-quark/imr.c causes these warnings:
"warning: Function parameter or member 'fmt' not described in 'pr_fmt'"
"warning: expecting prototype for c(). Prototype was for pr_fmt() instead"

Similarly for arch/x86/platform/intel-quark/imr_selftest.c too.

Provide a simple fix by replacing these occurrences with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20210330213022.28769-1-yashsri421@gmail.com

---
 arch/x86/platform/intel-quark/imr.c          | 2 +-
 arch/x86/platform/intel-quark/imr_selftest.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
index 122e0f3..d3d4569 100644
--- a/arch/x86/platform/intel-quark/imr.c
+++ b/arch/x86/platform/intel-quark/imr.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * imr.c -- Intel Isolated Memory Region driver
  *
  * Copyright(c) 2013 Intel Corporation.
diff --git a/arch/x86/platform/intel-quark/imr_selftest.c b/arch/x86/platform/intel-quark/imr_selftest.c
index 570e306..761f368 100644
--- a/arch/x86/platform/intel-quark/imr_selftest.c
+++ b/arch/x86/platform/intel-quark/imr_selftest.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * imr_selftest.c -- Intel Isolated Memory Region self-test driver
  *
  * Copyright(c) 2013 Intel Corporation.
