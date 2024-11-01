Return-Path: <linux-tip-commits+bounces-2686-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538919B906A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 12:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857A21C21682
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 11:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCB019CC29;
	Fri,  1 Nov 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VXMbWSjG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j6T9kXdk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0715820C;
	Fri,  1 Nov 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461271; cv=none; b=Mhgh1520ZeS3ZtpbFj92Zo0WU57tYAmEIw+Kr+WJ9W8bjNsvUu6Sf9mVXs7cFLsSmy6Uj8/unBpyiqZPtV6COp067k3dHhP7QYWEn0wXD4Aa90OHvV8tnGO4OVB3y5WYDxenHU7GjJPXegXDGt+JF2tOM3tPcUhqV762A7DLvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461271; c=relaxed/simple;
	bh=UdIAGckTW8RjUs2ghmb8at5uhhcaAQ3GiPCh2f5lALY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RSKZkwKrSG6HAOjt5TCcCPX1mTIHmp15DF7FMc99Eu8vS9P0KOxfy8wiPIWndpiFl7gRDDl5FiS6w0Cd4WQqYNFQsuK5RKe5dSFPzQK3A6di6MsXIp9HPLjTcWIBXivMG0QUAMfgMzNgyJPpordPgIWZXTXBcanNuw8XRWFNWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VXMbWSjG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j6T9kXdk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Nov 2024 11:41:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730461266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rf3pBeD8ZvjmViADPpDEx8qFMGx0bSQAAMGVXzrPn6A=;
	b=VXMbWSjGqn9ZAsh41T1jjgxP0/DxD+ITVGWxNhfriMIcJJzjTzj2KjJeku2p14UZVXIcx4
	3xVwmk04Twu6RT0oJXGW9+hjuZkCM0GCTsF2zdQrHzXy2DAxgXdeXs8tJpNg2+RNEI0g4X
	trjw7LEzrgbiMFL2H23Z21UgrcNTmCpA5Opyt/X120ByJDekZD2kA9dGVAr1egRso3xp6H
	EF/eGgrAbnu3qHQZtWLW6dwx1a7KtzWnFYymRAy6dGt9Kb3ZLjeIcfs0p1VyoXy5q2QAyb
	4ap2DJa7t8oAyIUfzQGMybX3N6Aasnf7QGt3oKRccUue0OJCDgh9edCpy//8tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730461266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rf3pBeD8ZvjmViADPpDEx8qFMGx0bSQAAMGVXzrPn6A=;
	b=j6T9kXdkXdN5MtZ18GL5tP0Rlrqyb6VtEJbs9RGD9712Ntcf7NMBlL00Zmnm3qicEDAnXj
	N9lCmuW7mZiJ9rAw==
From: "tip-bot2 for Steven Rostedt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] tracing: Add __print_dynamic_array() helper
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Avadhut Naik <avadhut.naik@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241022194158.110073-3-avadhut.naik@amd.com>
References: <20241022194158.110073-3-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173046126587.3137.17478186661563402818.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     e52750fb1458ae9ea5860a08ed7a149185bc5b97
Gitweb:        https://git.kernel.org/tip/e52750fb1458ae9ea5860a08ed7a149185bc5b97
Author:        Steven Rostedt <rostedt@goodmis.org>
AuthorDate:    Tue, 22 Oct 2024 19:36:28 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 30 Oct 2024 17:24:32 +01:00

tracing: Add __print_dynamic_array() helper

When printing a dynamic array in a trace event, the method is rather ugly.
It has the format of:

  __print_array(__get_dynamic_array(array),
            __get_dynmaic_array_len(array) / el_size, el_size)

Since dynamic arrays are known to the tracing infrastructure, create a
helper macro that does the above for you.

  __print_dynamic_array(array, el_size)

Which would expand to the same output.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://lore.kernel.org/r/20241022194158.110073-3-avadhut.naik@amd.com
---
 include/trace/stages/stage3_trace_output.h | 8 ++++++++
 include/trace/stages/stage7_class_define.h | 1 +
 samples/trace_events/trace-events-sample.h | 7 ++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index c1fb135..1e7b0be 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -119,6 +119,14 @@
 		trace_print_array_seq(p, array, count, el_size);	\
 	})
 
+#undef __print_dynamic_array
+#define __print_dynamic_array(array, el_size)				\
+	({								\
+		__print_array(__get_dynamic_array(array),		\
+			      __get_dynamic_array_len(array) / (el_size), \
+			      (el_size));				\
+	})
+
 #undef __print_hex_dump
 #define __print_hex_dump(prefix_str, prefix_type,			\
 			 rowsize, groupsize, buf, len, ascii)		\
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index bcb960d..fcd564a 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -22,6 +22,7 @@
 #undef __get_rel_cpumask
 #undef __get_rel_sockaddr
 #undef __print_array
+#undef __print_dynamic_array
 #undef __print_hex_dump
 #undef __get_buf
 
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 55f9a3d..999f78d 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -319,7 +319,7 @@ TRACE_EVENT(foo_bar,
 		__assign_cpumask(cpum, cpumask_bits(mask));
 	),
 
-	TP_printk("foo %s %d %s %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
+	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
 
 /*
  * Notice here the use of some helper functions. This includes:
@@ -363,6 +363,11 @@ TRACE_EVENT(foo_bar,
 		  __print_array(__get_dynamic_array(list),
 				__get_dynamic_array_len(list) / sizeof(int),
 				sizeof(int)),
+
+/*     A shortcut is to use __print_dynamic_array for dynamic arrays */
+
+		  __print_dynamic_array(list, sizeof(int)),
+
 		  __get_str(str), __get_str(lstr),
 		  __get_bitmask(cpus), __get_cpumask(cpum),
 		  __get_str(vstr))

