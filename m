Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB545114D16
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2019 09:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfLFIDy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Dec 2019 03:03:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60507 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfLFIDv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Dec 2019 03:03:51 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1id8aN-00053C-7X; Fri, 06 Dec 2019 09:03:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7A3161C24C6;
        Fri,  6 Dec 2019 09:03:34 +0100 (CET)
Date:   Fri, 06 Dec 2019 08:03:34 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers UAPI: Update tools's copy of drm.h headers
Cc:     Adrian Hunter <adrian.hunter@intel.com>, christian.koenig@amd.com,
        Chunming Zhou <david1.zhou@amd.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-t1xqmjffo4rxdw395dsnu34j@git.kernel.org>
References: <tip-t1xqmjffo4rxdw395dsnu34j@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157561941435.21853.6754518610466999114.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     fd9bee5e24141d00e23b66d1b51bc759efa7e3fe
Gitweb:        https://git.kernel.org/tip/fd9bee5e24141d00e23b66d1b51bc759efa7e3fe
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 04 Dec 2019 12:53:16 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 04 Dec 2019 16:22:38 -03:00

tools headers UAPI: Update tools's copy of drm.h headers

Picking the changes from:

  2093dea3def9 ("drm/syncobj: extend syncobj query ability v3")

Which doesn't affect tooling, just silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/drm.h' differs from latest version at 'include/uapi/drm/drm.h'
  diff -u tools/include/uapi/drm/drm.h include/uapi/drm/drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Chunming Zhou <david1.zhou@amd.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-t1xqmjffo4rxdw395dsnu34j@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/drm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 8a5b2f8..868bf79 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -778,11 +778,12 @@ struct drm_syncobj_array {
 	__u32 pad;
 };
 
+#define DRM_SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED (1 << 0) /* last available point on timeline syncobj */
 struct drm_syncobj_timeline_array {
 	__u64 handles;
 	__u64 points;
 	__u32 count_handles;
-	__u32 pad;
+	__u32 flags;
 };
 
 
