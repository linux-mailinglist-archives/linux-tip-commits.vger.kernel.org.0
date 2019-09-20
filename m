Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1AB7B9524
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Sep 2019 18:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404795AbfITQVK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Sep 2019 12:21:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52764 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404668AbfITQVJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLea-000419-Tb; Fri, 20 Sep 2019 18:21:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8CFAD1C0DF4;
        Fri, 20 Sep 2019 18:20:58 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:20:58 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf auxtrace: Add missing 'struct perf_sample'
 forward declaration
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-c3k1il7sm28old4e22nwlm7l@git.kernel.org>
References: <tip-c3k1il7sm28old4e22nwlm7l@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156899645850.24167.11885854086319085149.tip-bot2@tip-bot2>
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

Commit-ID:     bd23ac11fe9312bab40e129b402757fd7a23dc8e
Gitweb:        https://git.kernel.org/tip/bd23ac11fe9312bab40e129b402757fd7a23dc8e
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 18 Sep 2019 10:12:07 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 09:19:22 -03:00

perf auxtrace: Add missing 'struct perf_sample' forward declaration

Its needed, was being obtained indirectly, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c3k1il7sm28old4e22nwlm7l@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 37e70dc..1ed902a 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -24,6 +24,7 @@ struct perf_session;
 struct evlist;
 struct perf_tool;
 struct perf_mmap;
+struct perf_sample;
 struct option;
 struct record_opts;
 struct perf_record_auxtrace_info;
