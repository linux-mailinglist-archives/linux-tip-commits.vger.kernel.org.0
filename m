Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F608E7F2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Aug 2019 11:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfHOJSE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Aug 2019 05:18:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54911 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbfHOJSE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Aug 2019 05:18:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9HtsB2270463
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:17:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9HtsB2270463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565860676;
        bh=ukVRDUqoQeOP27TAvHo39H8XO24WHNna2kFHIo4hcWY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=yBpEP1c4NkKM93jIvSKT6ejof15ogmgV/PLR3PGbbsV2ncaqZvucIt2LW2c8ue4O1
         G136tL72xb3j5aVKWP6pAjrxgyldZs9wSkgpNzIed47UX6JcfRinASEiwTiv3KSBDc
         H8ZkE/PtXz2ojDoEcXLQkRXm+CfzB7Ww243kP0b7HAnTalncVmm0khR56VHatyJ9Lu
         ZE/rLwvr0r0sPHz/4xhYasQIjWwzca/Ee53KbUb+iTaf+5XSH1vBecxiB40YuU13zS
         e/+gR3+1MQKtIlAYGd7JAv7YcCIwVvqIUSxwvHhuZqMbL5cdlc8aWyf93NBpPWmY2a
         pC6mkwlgbziIQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9HsEs2270457;
        Thu, 15 Aug 2019 02:17:54 -0700
Date:   Thu, 15 Aug 2019 02:17:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0u4o967hsk7j0o50zp9ctn89@git.kernel.org>
Cc:     lclaudio@redhat.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
        treeze.taeung@gmail.com, namhyung@kernel.org, acme@redhat.com,
        jolsa@kernel.org, tglx@linutronix.de
Reply-To: lclaudio@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
          jolsa@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          namhyung@kernel.org, treeze.taeung@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf config: Document the PERF_CONFIG environment
 variable
Git-Commit-ID: 5de9e5fda05b580c036e1fec6e2d8bf78eb2ac9d
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

Commit-ID:  5de9e5fda05b580c036e1fec6e2d8bf78eb2ac9d
Gitweb:     https://git.kernel.org/tip/5de9e5fda05b580c036e1fec6e2d8bf78eb2ac9d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 30 Jul 2019 11:30:37 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Aug 2019 16:26:02 -0300

perf config: Document the PERF_CONFIG environment variable

There was a provision for setting this variable, but not the
getenv("PERF_CONFIG") call to set it, as this was fixed in the previous
cset, document that it can be used to ask for using an alternative
.perfconfig file or to disable reading whatever file exists in the
system or home directory, i.e. using:

  export PERF_CONFIG=/dev/null

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: https://lkml.kernel.org/n/tip-0u4o967hsk7j0o50zp9ctn89@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index e4aa268d2e38..c599623a1f3d 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -40,6 +40,10 @@ The '$HOME/.perfconfig' file is used to store a per-user configuration.
 The file '$(sysconfdir)/perfconfig' can be used to
 store a system-wide default configuration.
 
+One an disable reading config files by setting the PERF_CONFIG environment
+variable to /dev/null, or provide an alternate config file by setting that
+variable.
+
 When reading or writing, the values are read from the system and user
 configuration files by default, and options '--system' and '--user'
 can be used to tell the command to read from or write to only that location.
