Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80ABE909E4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Aug 2019 23:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfHPVBW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Aug 2019 17:01:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49923 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPVBW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Aug 2019 17:01:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GL18l32960880
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 14:01:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GL18l32960880
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565989268;
        bh=Q+6F7TluFBK2tIaqc8cWv7BEw07K7Xt56N49104j54g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YLVVtCJJaJ5gE4M9bzqt3ZqihCzfCspCuZ8sOzKTQnqFoU9uNmEr8WdCE4Hf9C9Q5
         u9etIQSiM+cGZk3DyTsttJJLpIM4YnCJbnj81GBCAQh1flH0KigiwjdyRkYcWncDXH
         F7yeBIH+fgXIKh4O+i/ZF8fu4h/k3G5gjfLydpEeZwaGmjQiqyfRsRbJNk8SBuOb43
         vWqBRGQHavj1Axwl8izXc79UBexOcMN2FsgJ0fEtD3sCx0652ZFZ4+GZev0Z9ME0h5
         diCWCpJgFCyjdovuS9P9miE0wYqF4SRDRukTVIwo3WYIoRolRFBl7Z6u3QLtrPSCen
         c6GporIXSOQvQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GL176p2960864;
        Fri, 16 Aug 2019 14:01:07 -0700
Date:   Fri, 16 Aug 2019 14:01:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for John Keeping <tipbot@zytor.com>
Message-ID: <tip-e2736219e6ca3117e10651e215b96d66775220da@git.kernel.org>
Cc:     namhyung@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        khlebnikov@yandex-team.ru, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, john@metanate.com, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: namhyung@kernel.org, khlebnikov@yandex-team.ru,
          peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
          john@metanate.com, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20190815100146.28842-3-john@metanate.com>
References: <20190815100146.28842-3-john@metanate.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf unwind: Remove unnecessary test
Git-Commit-ID: e2736219e6ca3117e10651e215b96d66775220da
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  e2736219e6ca3117e10651e215b96d66775220da
Gitweb:     https://git.kernel.org/tip/e2736219e6ca3117e10651e215b96d66775220da
Author:     John Keeping <john@metanate.com>
AuthorDate: Thu, 15 Aug 2019 11:01:46 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Aug 2019 12:30:14 -0300

perf unwind: Remove unnecessary test

If dwarf_callchain_users is false, then unwind__prepare_access() will
not set unwind_libunwind_ops so the remaining test here is sufficient.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: john keeping <john@metanate.com>
Link: http://lkml.kernel.org/r/20190815100146.28842-3-john@metanate.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/unwind-libunwind.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index b843f9d0a9ea..6499b22b158b 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -69,18 +69,12 @@ out_register:
 
 void unwind__flush_access(struct map_groups *mg)
 {
-	if (!dwarf_callchain_users)
-		return;
-
 	if (mg->unwind_libunwind_ops)
 		mg->unwind_libunwind_ops->flush_access(mg);
 }
 
 void unwind__finish_access(struct map_groups *mg)
 {
-	if (!dwarf_callchain_users)
-		return;
-
 	if (mg->unwind_libunwind_ops)
 		mg->unwind_libunwind_ops->finish_access(mg);
 }
