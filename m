Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69BA86B50
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2019 22:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404479AbfHHUUY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Aug 2019 16:20:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50515 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404467AbfHHUUX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Aug 2019 16:20:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78KK7j53321408
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 13:20:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78KK7j53321408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565295608;
        bh=lX1hCaVCNaoNqHRRttyKwMgi6ZhuouRYalN700/XUvs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=219bwk71GfkGDzN4kMGaCzm9U8T5RIiYYNJ0SeOeTdHWBup5EzPswJu1J8V2tf6yT
         IBeN01ErrPyi3R1hYw/wd/ouvPpXhOoe/T8CifO4IYl3GUaUIUQpzjYU23qvQBJp8l
         eoJDd9IT4qaymhAzj9p98NLkf40s1z/Ei9ak63oFusBiDr3SpboGK07TN2mH6k3Q2J
         NZQ8G/JzbBnmgiA91uZMa6O7poK9zeB8dC/cebI50Arf+2uIAvEt62X4ZYdAWkgUJ7
         ymTpr+sTs12dEin/1W96YxtJhrYXypVrx0Z+HoVwudq1vj90/ASFvmDvV/s5tv1KMT
         zt8nmZoJ2bpGQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78KK7DB3321405;
        Thu, 8 Aug 2019 13:20:07 -0700
Date:   Thu, 8 Aug 2019 13:20:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masanari Iida <tipbot@zytor.com>
Message-ID: <tip-89b66500f739e0033ef59011e3df694f2053679d@git.kernel.org>
Cc:     namhyung@kernel.org, peterz@infradead.org, standby24x7@gmail.com,
        hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        mojha@codeaurora.org, mingo@kernel.org
Reply-To: acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          mojha@codeaurora.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          standby24x7@gmail.com, peterz@infradead.org, namhyung@kernel.org
In-Reply-To: <20190801032812.25018-1-standby24x7@gmail.com>
References: <20190801032812.25018-1-standby24x7@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix a typo in a variable name in the
 Documentation Makefile
Git-Commit-ID: 89b66500f739e0033ef59011e3df694f2053679d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=2.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT autolearn=no
        autolearn_force=no version=3.4.2
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  89b66500f739e0033ef59011e3df694f2053679d
Gitweb:     https://git.kernel.org/tip/89b66500f739e0033ef59011e3df694f2053679d
Author:     Masanari Iida <standby24x7@gmail.com>
AuthorDate: Thu, 1 Aug 2019 12:28:12 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Aug 2019 15:41:10 -0300

perf tools: Fix a typo in a variable name in the Documentation Makefile

This patch fix a spelling typo in a variable name in the Documentation Makefile.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190801032812.25018-1-standby24x7@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 6d148a40551c..adc5a7e44b98 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -242,7 +242,7 @@ $(OUTPUT)doc.dep : $(wildcard *.txt) build-docdep.perl
 	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
 
--include $(OUPTUT)doc.dep
+-include $(OUTPUT)doc.dep
 
 _cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-ancillarymanipulators.txt \
