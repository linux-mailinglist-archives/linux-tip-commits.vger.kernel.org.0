Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCD3122A19
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Dec 2019 12:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfLQLcC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Dec 2019 06:32:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55037 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfLQLcC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Dec 2019 06:32:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihB4z-0007ML-Sb; Tue, 17 Dec 2019 12:31:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6B07A1C2A36;
        Tue, 17 Dec 2019 12:31:53 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:31:53 -0000
From:   "tip-bot2 for Sudip Mukherjee" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] libtraceevent: Allow custom libdir path
Cc:     Sudipm Mukherjee <sudipm.mukherjee@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191207111440.6574-1-sudipm.mukherjee@gmail.com>
References: <20191207111440.6574-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Message-ID: <157658231328.30329.8418426523383636239.tip-bot2@tip-bot2>
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

Commit-ID:     c09982f8e2bae80a66232630ec4ba50afacea486
Gitweb:        https://git.kernel.org/tip/c09982f8e2bae80a66232630ec4ba50afacea486
Author:        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
AuthorDate:    Sat, 07 Dec 2019 11:14:40 
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 16 Dec 2019 13:40:26 -03:00

libtraceevent: Allow custom libdir path

When I use prefix=/usr and try to install libtraceevent in my laptop it
tries to install in /usr/lib64. I am not having any folder as /usr/lib64
and also the debian policy doesnot allow installing in /usr/lib64. It
should be in /usr/lib/x86_64-linux-gnu/.

Quote: No package for a 64 bit architecture may install files in
	/usr/lib64/ or in a subdirectory of it.

ref: https://www.debian.org/doc/debian-policy/ch-opersys.html

Make it more flexible by allowing to mention libdir_relative while
installing so that distros can mention the path according to their
policy or use the default one.

Signed-off-by: Sudipm Mukherjee <sudipm.mukherjee@gmail.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Sudipm Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/lkml/20191207111440.6574-1-sudipm.mukherjee@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Makefile         | 5 +++--
 tools/lib/traceevent/plugins/Makefile | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index c5a0335..c874c01 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -39,11 +39,12 @@ DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
 
 LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
 ifeq ($(LP64), 1)
-  libdir_relative = lib64
+  libdir_relative_temp = lib64
 else
-  libdir_relative = lib
+  libdir_relative_temp = lib
 endif
 
+libdir_relative ?= $(libdir_relative_temp)
 prefix ?= /usr/local
 libdir = $(prefix)/$(libdir_relative)
 man_dir = $(prefix)/share/man
diff --git a/tools/lib/traceevent/plugins/Makefile b/tools/lib/traceevent/plugins/Makefile
index f440989..349bb81 100644
--- a/tools/lib/traceevent/plugins/Makefile
+++ b/tools/lib/traceevent/plugins/Makefile
@@ -32,11 +32,12 @@ DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
 
 LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
 ifeq ($(LP64), 1)
-  libdir_relative = lib64
+  libdir_relative_tmp = lib64
 else
-  libdir_relative = lib
+  libdir_relative_tmp = lib
 endif
 
+libdir_relative ?= $(libdir_relative_tmp)
 prefix ?= /usr/local
 libdir = $(prefix)/$(libdir_relative)
 
