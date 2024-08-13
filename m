Return-Path: <linux-tip-commits+bounces-2039-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B49508DB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 17:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725C11F25440
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1491A01CD;
	Tue, 13 Aug 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vA7fe7vW"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEAB19E837
	for <linux-tip-commits@vger.kernel.org>; Tue, 13 Aug 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562414; cv=none; b=H9+FFZlybGcYs49EUNg8TdHV97eJxySpM9i1ZesOc9LNBYmkdAD0Gl9F4wNgA+GJHrFcWNV+l7c8uRhw17BJLQvQKXFRbt2Xg1YiU8GRVXYtOrm60u7sjLaCCMPhf1+0Yb0or441Vq2irXYCXeikUCZU26q1vVohDCyPDIruPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562414; c=relaxed/simple;
	bh=Ex/4s0n9Wlkjxzt+w5ISr7vYWVr1LCoZcvVs14MM4n4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q4qEeYDRzpqrSgg+jVWEzlMczoWKOlZymQLheLG533Ih2allQxaLYWHddfLGezXkz8cNyfor93vcSTKOA4Nn3dre42TlBy0eHGIsY65MqWWSihWJ1bpK0ZGt2xSGLk0+ju7szz4/EEGlF1UinYHQPIsoHSw8UKGsdTNNiY7giys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vA7fe7vW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd90c2fc68so38503975ad.1
        for <linux-tip-commits@vger.kernel.org>; Tue, 13 Aug 2024 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723562411; x=1724167211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGNEi3587iZMzQAx8PsQPjx0OaYa7mQ3Rko5ZfLhD1s=;
        b=vA7fe7vWhHKhcakMjwvZTbHT2443emYR54tccJxDWiXrpD5vv0sq0YKkt76G3lFYes
         OG2vi9nqFfEitbaa7+0EX0zyed/wcpryNhmI9rHMl7aNxQzR2M8T2JFYG9/7/qVNYeUm
         RqRmXpXnbf0wiyS35CA/IhiOJzyB8NV1zmBskv4zizHaX2XdUMerXhijsbS8i/LT48SX
         fEb+WuR5qMir2FheSn0WDi+tUi7nHTaHWr+KnVfw9HSUSSJLO6WwKCWPwm6I8ax+Laup
         2bRvjfURKWS1MXxgwESmqa+HNJktQ0CQ2gE+2lU4WADH1CIrIujAvrIji0XsVW1E6Dys
         akwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562411; x=1724167211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGNEi3587iZMzQAx8PsQPjx0OaYa7mQ3Rko5ZfLhD1s=;
        b=BxgaB5oLVZFHl3D5bshAsvrT6wBkywk99Lx3mzC08hayVCHAR6VfFDhbqil+Jv/vY+
         dcWSTbCm+SmZS05PPWoboKrq8eSbxLKc6NDeBFGEO4k0JMddfNoBSTkpvV58EZYSau5z
         wPepjApRyWn301RiboexdKBSyo/BYsfSmBwX7qJr0gS0F2XrMuatXlHVNncbayxdBLyx
         FUU0Bk+f6BULxq2r0w+LSLhmI57GF+2hRZ8miCYTUZVYkrwFCqVyRZcXRQMGFqG2bKBI
         bWmpRRmU/xQfsfRxqes6kVHnTaksW1W4GTtJTetxhrhUWhZhD58+Y0xouz12fFXmpyll
         btsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0ndUzQmqSUaDCPbt78H1uz3PHtY6ZmygLdaykyCE2livIoF8a98zTVg1RsxWZrJpgVCFSbUE6nhMbV4Ng2XQrIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOX2EpYbCu/C/hUniVo1bMdmIL/tDuy9dn7G6iEvBQacLTi9CW
	9gfiVN0Mw0SIV8yGSMXL01g0lfJzGhe1I0Js5pjevZkqUswotjsXxEIeQu1vITw=
X-Google-Smtp-Source: AGHT+IE8uzl+3XDJlRev6wMOOrc8e3Ejv3qLCWrnT22nxnfnW/dq8+NzlrUysh3GtRGPuNqISZqLhQ==
X-Received: by 2002:a17:903:428b:b0:200:a9f3:c347 with SMTP id d9443c01a7336-201ca17967cmr36215175ad.39.1723562411280;
        Tue, 13 Aug 2024 08:20:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00c:205b:90fd:1c5d:56bb:2b97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a9403sm14677645ad.151.2024.08.13.08.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:20:10 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: pengfei.xu@intel.com
Cc: kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	namhyung@kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com,
	x86@kernel.org,
	lkft-triage@lists.linaro.org,
	dan.carpenter@linaro.org,
	anders.roxell@linaro.org,
	arnd@arndb.de,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [tip: perf/core] perf: Fix event_function_call() locking
Date: Tue, 13 Aug 2024 20:49:59 +0530
Message-Id: <20240813151959.99058-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Zrq4PRAVxjlnvFnb@xpf.sh.intel.com>
References: <Zrq4PRAVxjlnvFnb@xpf.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While running LTP test cases splice07 and perf_event_open01 found following
kernel BUG running on arm64 device juno-r2 and qemu-arm64 on the Linux
next-20240812 and next-20240813 tag.

  GOOD: next-20240809
  BAD: next-20240812

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
--------
[ 2278.760258] check_preemption_disabled: 15 callbacks suppressed
[ 2278.760282] BUG: using smp_processor_id() in preemptible [00000000] code: perf_event_open/111076
[ 2278.775032] caller is debug_smp_processor_id+0x20/0x30
[ 2278.780270] CPU: 5 UID: 0 PID: 111076 Comm: perf_event_open Not tainted 6.11.0-rc3-next-20240812 #1
[ 2278.789344] Hardware name: ARM Juno development board (r2) (DT)
[ 2278.795276] Call trace:
[ 2278.797724]  dump_backtrace+0x9c/0x128
[ 2278.801487]  show_stack+0x20/0x38
[ 2278.804812]  dump_stack_lvl+0xbc/0xd0
[ 2278.808487]  dump_stack+0x18/0x28
[ 2278.811811]  check_preemption_disabled+0xd8/0xf8
[ 2278.816446]  debug_smp_processor_id+0x20/0x30
[ 2278.820818]  event_function_call+0x54/0x168
[ 2278.825015]  _perf_event_enable+0x78/0xa8
[ 2278.829037]  perf_event_for_each_child+0x44/0xa0
[ 2278.833672]  _perf_ioctl+0x1bc/0xae0
[ 2278.837262]  perf_ioctl+0x58/0x90
[ 2278.840590]  __arm64_sys_ioctl+0xb4/0x100
[ 2278.844615]  invoke_syscall+0x50/0x120
[ 2278.848381]  el0_svc_common.constprop.0+0x48/0xf0
[ 2278.853103]  do_el0_svc+0x24/0x38
[ 2278.856432]  el0_svc+0x3c/0x108
[ 2278.859585]  el0t_64_sync_handler+0x120/0x130
[ 2278.863956]  el0t_64_sync+0x190/0x198
[ 2279.068732] BUG: using smp_processor_id() in preemptible [00000000] code: perf_event_open/111076
[ 2279.077570] caller is debug_smp_processor_id+0x20/0x30
[ 2279.082754] CPU: 1 UID: 0 PID: 111076 Comm: perf_event_open Not tainted 6.11.0-rc3-next-20240812 #1
[ 2279.091823] Hardware name: ARM Juno development board (r2) (DT)

Full test log:
---------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240813/testrun/24833616/suite/log-parser-test/test/check-kernel-bug/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240813/testrun/24833616/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240812/testrun/24821160/suite/log-parser-test/test/check-kernel-bug-483bde618da4ec98e33eefb5e26adeb267f80cc2461569605f3166ce12b3fe82/log

metadata:
  artifact-location: https://storage.tuxsuite.com/public/linaro/lkft/builds/2kXsz6nJO7pJ1nL4xGlKHYhiLx9/
  build-url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2kXsz6nJO7pJ1nL4xGlKHYhiLx9/
  build_name: gcc-13-lkftconfig-debug
  git_describe: next-20240812
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 9e6869691724b12e1f43655eeedc35fade38120c
  kernel-config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2kXsz6nJO7pJ1nL4xGlKHYhiLx9/config
  kernel_version: 6.11.0-rc3
  toolchain: gcc-13

--
Linaro LKFT
https://lkft.linaro.org

