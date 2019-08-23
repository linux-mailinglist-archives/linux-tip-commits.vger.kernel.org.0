Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2325D9A5AF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 04:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391276AbfHWCoV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Aug 2019 22:44:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33852 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389842AbfHWCoV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Aug 2019 22:44:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0zYm-0001Md-6a; Fri, 23 Aug 2019 04:44:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 968171C07E4;
        Fri, 23 Aug 2019 04:44:15 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:44:15 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] tools headers: Add limits.h to access __WORDSIZE
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
In-Reply-To: <tip-5yfoed4rnsck2n3cwhm9mvth@git.kernel.org>
References: <tip-5yfoed4rnsck2n3cwhm9mvth@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156652825547.13140.595664236026125012.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6e98bc349ea4219e21785d85809b10bd49e722df
Gitweb:        https://git.kernel.org/tip/6e98bc349ea4219e21785d85809b10bd49e722df
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 20 Aug 2019 12:01:38 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:03:05 -03:00

tools headers: Add limits.h to access __WORDSIZE

We need to make sure limits.h is included before checking if we can use
__WORDSIZE, do it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5yfoed4rnsck2n3cwhm9mvth@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index 0b0ef3a..140c836 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -3,6 +3,7 @@
 #define _TOOLS_LINUX_BITOPS_H_
 
 #include <asm/types.h>
+#include <limits.h>
 #ifndef __WORDSIZE
 #define __WORDSIZE (__SIZEOF_LONG__ * 8)
 #endif
