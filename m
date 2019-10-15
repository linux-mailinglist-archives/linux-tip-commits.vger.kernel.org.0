Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40580D6EE3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2019 07:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfJOFcS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Oct 2019 01:32:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42217 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfJOFcS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRL-0000Tp-FY; Tue, 15 Oct 2019 07:32:11 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9F1F21C06D8;
        Tue, 15 Oct 2019 07:31:50 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:50 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf scripts python: exported-sql-viewer.py: Add
 HBoxLayout and VBoxLayout
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821083216.1340-3-adrian.hunter@intel.com>
References: <20190821083216.1340-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157111751054.12254.15315606820634417569.tip-bot2@tip-bot2>
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

Commit-ID:     42c303ff9a25c4b95a75f8f10d08661183497d41
Gitweb:        https://git.kernel.org/tip/42c303ff9a25c4b95a75f8f10d08661183497d41
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 21 Aug 2019 11:32:12 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:17 -03:00

perf scripts python: exported-sql-viewer.py: Add HBoxLayout and VBoxLayout

Add layout classes HBoxLayout and VBoxLayout.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20190821083216.1340-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 41 +++++++++++----
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 18ad046..9767a5f 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -980,20 +980,41 @@ class CallTreeModel(CallGraphModelBase):
 		ids.insert(0, query.value(1))
 		return ids
 
-# Vertical widget layout
+# Vertical layout
 
-class VBox():
+class HBoxLayout(QHBoxLayout):
 
-	def __init__(self, w1, w2, w3=None):
-		self.vbox = QWidget()
-		self.vbox.setLayout(QVBoxLayout())
+	def __init__(self, *children):
+		super(HBoxLayout, self).__init__()
+
+		self.layout().setContentsMargins(0, 0, 0, 0)
+		for child in children:
+			if child.isWidgetType():
+				self.layout().addWidget(child)
+			else:
+				self.layout().addLayout(child)
+
+# Horizontal layout
+
+class VBoxLayout(QVBoxLayout):
 
-		self.vbox.layout().setContentsMargins(0, 0, 0, 0)
+	def __init__(self, *children):
+		super(VBoxLayout, self).__init__()
 
-		self.vbox.layout().addWidget(w1)
-		self.vbox.layout().addWidget(w2)
-		if w3:
-			self.vbox.layout().addWidget(w3)
+		self.layout().setContentsMargins(0, 0, 0, 0)
+		for child in children:
+			if child.isWidgetType():
+				self.layout().addWidget(child)
+			else:
+				self.layout().addLayout(child)
+
+# Vertical layout widget
+
+class VBox():
+
+	def __init__(self, *children):
+		self.vbox = QWidget()
+		self.vbox.setLayout(VBoxLayout(*children))
 
 	def Widget(self):
 		return self.vbox
