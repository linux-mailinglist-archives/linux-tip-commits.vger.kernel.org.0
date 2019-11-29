Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B4310D14A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Nov 2019 07:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfK2GDI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Nov 2019 01:03:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48084 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfK2GDH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMt-0008NL-1N; Fri, 29 Nov 2019 07:03:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7B5D41C210C;
        Fri, 29 Nov 2019 07:02:53 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:53 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf map: Remove needless struct forward declarations
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-hnao13231bsl7xml5wn8h4iu@git.kernel.org>
References: <tip-hnao13231bsl7xml5wn8h4iu@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157500737338.21853.4104340810692264441.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     805fcbc4fb669036e0137c9a655c8bf0dd08cb5b
Gitweb:        https://git.kernel.org/tip/805fcbc4fb669036e0137c9a655c8bf0dd08cb5b
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 22 Nov 2019 12:48:24 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 26 Nov 2019 11:07:45 -03:00

perf map: Remove needless struct forward declarations

At some point we may have needed that, not anymore.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hnao13231bsl7xml5wn8h4iu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index c0dffa9..aafaea2 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -12,11 +12,8 @@
 #include <linux/types.h>
 
 struct dso;
-struct ip_callchain;
-struct ref_reloc_sym;
 struct map_groups;
 struct machine;
-struct evsel;
 
 struct map {
 	union {
