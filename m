Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D17A8E7F6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Aug 2019 11:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbfHOJSu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Aug 2019 05:18:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33777 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfHOJSu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Aug 2019 05:18:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9Ig4f2270753
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:18:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9Ig4f2270753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565860723;
        bh=Ti+A5DmLubGWvxE+G1z/lwt3lnWYsZKvzG65MGPjIwY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=393BsZMwOOSwkU8wqdQqHWE6lrKyzIbz/p97776ZEiPInl5vznjy+5ovqiNS4qTJX
         lWZ8uxbznzgMScfz5cJrc3H/t0B9hzsEUlvKFng7TMQdnhmz78G9s9Pg138aADq8rC
         k2bCi4OIG2m1xNRYTX12jjBX16IEnT8z0xxSBBTnwKPw76Ssh2+Ud7LWttETcCl+5V
         Gi1k83l4REyAoeowXpYmpBNlL7Q+6D458QXlwtI7yaqPuKM97BdFu33DgZ2eykuaXY
         VKM2EF7PFZmZbAiYj34a7+VYvQKyyNYCSZxz4ZxZZ4glDmGJLLSoqXv6pY/TKA1S1F
         9sZ9brXQXCX9w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9IgLR2270750;
        Thu, 15 Aug 2019 02:18:42 -0700
Date:   Thu, 15 Aug 2019 02:18:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3up27pexg5i3exuzqrvt4m8u@git.kernel.org>
Cc:     namhyung@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, lclaudio@redhat.com,
        hpa@zytor.com, adrian.hunter@intel.com, treeze.taeung@gmail.com,
        acme@redhat.com, jolsa@kernel.org
Reply-To: adrian.hunter@intel.com, hpa@zytor.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          lclaudio@redhat.com, mingo@kernel.org, treeze.taeung@gmail.com,
          jolsa@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test vfs_getname: Disable ~/.perfconfig to get
 default output
Git-Commit-ID: 4fe94ce1c6ba678b5f12b94bb9996eea4fc99e85
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=1.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  4fe94ce1c6ba678b5f12b94bb9996eea4fc99e85
Gitweb:     https://git.kernel.org/tip/4fe94ce1c6ba678b5f12b94bb9996eea4fc99e85
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 30 Jul 2019 11:37:44 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Aug 2019 16:26:02 -0300

perf test vfs_getname: Disable ~/.perfconfig to get default output

To get the expected output we have to ignore whatever changes the user
has in its ~/.perfconfig file, so set PERF_CONFIG to /dev/null to
achieve that.

Before:

  # egrep 'trace|show_' ~/.perfconfig
  [trace]
  	show_zeros = yes
  	show_duration = no
  	show_timestamp = no
  	show_arg_names = no
  	show_prefix = yes
  # echo $PERF_CONFIG

  # perf test "trace + vfs_getname"
  70: Check open filename arg using perf trace + vfs_getname: FAILED!
  # export PERF_CONFIG=/dev/null
  # perf test "trace + vfs_getname"
  70: Check open filename arg using perf trace + vfs_getname: Ok
  #

After:

  # egrep 'trace|show_' ~/.perfconfig
  [trace]
  	show_zeros = yes
  	show_duration = no
  	show_timestamp = no
  	show_arg_names = no
  	show_prefix = yes
  # echo $PERF_CONFIG

  # perf test "trace + vfs_getname"
  70: Check open filename arg using perf trace + vfs_getname: Ok
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: https://lkml.kernel.org/n/tip-3up27pexg5i3exuzqrvt4m8u@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 45d269b0157e..11cc2af13f2b 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -32,6 +32,10 @@ if [ $err -ne 0 ] ; then
 	exit $err
 fi
 
+# Do not use whatever ~/.perfconfig file, it may change the output
+# via trace.{show_timestamp,show_prefix,etc}
+export PERF_CONFIG=/dev/null
+
 trace_open_vfs_getname
 err=$?
 rm -f ${file}
