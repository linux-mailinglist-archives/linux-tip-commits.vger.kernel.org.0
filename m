Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4111810D15C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Nov 2019 07:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfK2GD5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Nov 2019 01:03:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48054 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfK2GDE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMq-0008Nv-2y; Fri, 29 Nov 2019 07:03:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A14C01C210D;
        Fri, 29 Nov 2019 07:02:53 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:53 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf map: Ditch leftover map__reloc_vmlinux() prototype
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-35yy50cgpcx8cjorluwd5j53@git.kernel.org>
References: <tip-35yy50cgpcx8cjorluwd5j53@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157500737356.21853.5715037550449349985.tip-bot2@tip-bot2>
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

Commit-ID:     40df3897f0867f2e3700b4f216698288495053ef
Gitweb:        https://git.kernel.org/tip/40df3897f0867f2e3700b4f216698288495053ef
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 22 Nov 2019 12:44:10 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 26 Nov 2019 11:07:45 -03:00

perf map: Ditch leftover map__reloc_vmlinux() prototype

In 39b12f781271 ("perf tools: Make it possible to read object code from vmlinux")
the actual function was removed, but we forgot to remove the prototype,
fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-35yy50cgpcx8cjorluwd5j53@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 1f110b5..c0dffa9 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -144,8 +144,6 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name);
 void map__fixup_start(struct map *map);
 void map__fixup_end(struct map *map);
 
-void map__reloc_vmlinux(struct map *map);
-
 int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name,
 				    u64 addr);
 
