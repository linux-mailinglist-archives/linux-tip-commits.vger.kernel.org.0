Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACB2F8E26
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Nov 2019 12:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKLLTb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Nov 2019 06:19:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34001 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfKLLSb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBm-0000mU-GW; Tue, 12 Nov 2019 12:18:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C822F1C0673;
        Tue, 12 Nov 2019 12:18:18 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:18 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf session: Fix indent in perf_session__new()"
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007112027.GD6919@krava>
References: <20191007112027.GD6919@krava>
MIME-Version: 1.0
Message-ID: <157355749842.29376.3730865346376407105.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     01e97a59ea3e071e5c60ad46c40b4db748bfe928
Gitweb:        https://git.kernel.org/tip/01e97a59ea3e071e5c60ad46c40b4db748bfe928
Author:        Jiri Olsa <jolsa@redhat.com>
AuthorDate:    Mon, 07 Oct 2019 13:20:27 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:05 -03:00

perf session: Fix indent in perf_session__new()"

Fix up indentation.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lore.kernel.org/lkml/20191007112027.GD6919@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 6cc32f5..0266604 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -227,8 +227,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
 			/* Open the directory data. */
 			if (data->is_dir) {
 				ret = perf_data__open_dir(data);
-			if (ret)
-				goto out_delete;
+				if (ret)
+					goto out_delete;
 			}
 		}
 	} else  {
