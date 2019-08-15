Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A908E807
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Aug 2019 11:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbfHOJVD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Aug 2019 05:21:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44801 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbfHOJVD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Aug 2019 05:21:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9KtTN2270943
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:20:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9KtTN2270943
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565860856;
        bh=i6A/28iwIBUJHa3y2ozSH6Drz8wmQPMXfjLx+p5iyHI=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=1kdlT60Q7l+3zAqw+30XfZm7G0+fj0kWDSlvatD8NWnGjDzjdvO2WIF7CrJk+TMH7
         1JZKSFN2hL6EUaMZV/0RLx45ny4+JUEtiaLp5oAq+GEQ0YOUUItd+TklYJ9xevSuHd
         WyQgpqKgbZ5QCUg0Gn71RWAA1cViijzuVqnhBu4/5QEkILxVoGMZGEnDAcQzBm0GM/
         0JEU2l9C3d2+DLexeYV0HQMaNqn0O2g4ANiUQy9HM9z+hQIWBXhWihXNEPVlLOHGCy
         E0lLwD7cbp7p59daXyCgm7PlPtdpCaLpJRbOwgndoqkfW3O/H5bBU9jrODmj0+wAfx
         ++oe7AwdPfgAQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9KsYo2270940;
        Thu, 15 Aug 2019 02:20:54 -0700
Date:   Thu, 15 Aug 2019 02:20:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-5w0hmlk3zfvysxvpsh763k9w@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, jolsa@kernel.org,
        acme@redhat.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, namhyung@kernel.org, acme@redhat.com,
          jolsa@kernel.org, mingo@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Set display thread COMM to help with
 debugging
Git-Commit-ID: 1205a2719e52b6b52e0f9c0011554419da0377a0
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

Commit-ID:  1205a2719e52b6b52e0f9c0011554419da0377a0
Gitweb:     https://git.kernel.org/tip/1205a2719e52b6b52e0f9c0011554419da0377a0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Aug 2019 11:20:42 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Aug 2019 16:26:02 -0300

perf top: Set display thread COMM to help with debugging

When we want to attach just to the thread that updates the display it
helps having its COMM stand out, so change it from the default "perf" to
"perf-top-UI".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5w0hmlk3zfvysxvpsh763k9w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1a4615a5f6c9..94e34853a238 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -601,6 +601,8 @@ static void *display_thread_tui(void *arg)
 	 */
 	unshare(CLONE_FS);
 
+	prctl(PR_SET_NAME, "perf-top-UI", 0, 0, 0);
+
 	perf_top__sort_new_samples(top);
 
 	/*
@@ -651,6 +653,8 @@ static void *display_thread(void *arg)
 	 */
 	unshare(CLONE_FS);
 
+	prctl(PR_SET_NAME, "perf-top-UI", 0, 0, 0);
+
 	display_setup_sig();
 	pthread__unblock_sigwinch();
 repeat:
