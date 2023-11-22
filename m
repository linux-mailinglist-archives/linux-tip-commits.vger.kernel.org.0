Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAD67F5347
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Nov 2023 23:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344624AbjKVWTx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Nov 2023 17:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjKVWTx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Nov 2023 17:19:53 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAB510C
        for <linux-tip-commits@vger.kernel.org>; Wed, 22 Nov 2023 14:19:49 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ca26c07848so3396537b3.0
        for <linux-tip-commits@vger.kernel.org>; Wed, 22 Nov 2023 14:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700691588; x=1701296388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4w9WGlpV+oKNURgCWJmbzMqmytRuxi/IH9HmVAy3vpk=;
        b=zhLZGpAUuA/22M6TtGTHGgS7ilS41Jy1MH6OMzs/tYtIb0rnu7PKKJQtkcLQFUKj2r
         tXJu31m7WDO5kWi12UnGqE31cgqyQnmurs2kNufAZ/i2vzMAxb76QBkeT79NLxiuQo6+
         A97fasyVXyuwgUAiaWEvtgWomhIJCxwr/TgQb0EEPe5A+EioK/wpVrAWTsSLJA6XVQsx
         WIzv09c8r0RkuSPvbkZftTXYkp0rjCQY3R6Mrc8YqGx7Y21ZokQNEbv/fbgXI+9k10YO
         KJekmRAlZOY1oqhIRrqVEzBuSv+XtIXcU0kf3pdRaLPsag/oO4QRCaWrN2Qon0FRjO7w
         ypdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691588; x=1701296388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4w9WGlpV+oKNURgCWJmbzMqmytRuxi/IH9HmVAy3vpk=;
        b=kjtv8I1rJ0lXdlA0rEDWuBFXo0hAUWADq8dgJfprVDHj+ahLK4aJ1y99XwtV8rJuIK
         uTtnK6+AIax4ABfQ6JfwwoQgdBC///OyFjo29MJRnBjmM0vftXZsGixLda3EINaRRtez
         ee3TqJnmq5+bXEy6jcmkwro4i5wNKWaPnzvu6/b2FGRkYUkocxrFuFNi3d3Aai74CuSF
         m14lTRebeywTpR2Phz74v3vU+blzPLE8TChSPH1BA/fJwgIwgFI6eneKByhIA8NIRiNF
         VydBBtLfSsrTGv9fVdg1x64jAODN76i8QL1GMsS/s0w6VsFq+Yjvq7ZZFxysV21M1ran
         PbcA==
X-Gm-Message-State: AOJu0YyQu2Dkz7v84kGmXCjh9eE2AnbsqrJDN8HavHXFs7PmMHxk3yMy
        hmm8YDUEtnZ9OVwHNhI84Y0p+aoKYHg4Z+Q=
X-Google-Smtp-Source: AGHT+IHSDwqtRBxMdDOnZwBq01UvhHo5RWciGN7c3Nmk1lbfhcd8KQUoKkkA0peDZ+LMczKoiDc2N2BAek7agzE=
X-Received: from jsperbeck7.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:26dc])
 (user=jsperbeck job=sendgmr) by 2002:a05:6902:1801:b0:daf:660e:9bdb with SMTP
 id cf1-20020a056902180100b00daf660e9bdbmr101297ybb.6.1700691588594; Wed, 22
 Nov 2023 14:19:48 -0800 (PST)
Date:   Wed, 22 Nov 2023 22:19:47 +0000
In-Reply-To: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
Mime-Version: 1.0
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231122221947.781812-1-jsperbeck@google.com>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
From:   John Sperbeck <jsperbeck@google.com>
To:     tip-bot2@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        peterz@infradead.org, rui.zhang@intel.com, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

I have a platform with both LOCAL_APIC and LOCAL_X2APIC entries for
each CPU.  However, the ids for the LOCAL_APIC entries are all
invalid ids of 255, so they have always been skipped in acpi_parse_lapic()
by this code from f3bf1dbe64b6 ("x86/acpi: Prevent LAPIC id 0xff from being
accounted"):

    /* Ignore invalid ID */
    if (processor->id == 0xff)
            return 0;

With the change in this thread, the return value of 0 means that the
'count' variable in acpi_parse_entries_array() is incremented.  The
positive return value means that 'has_lapic_cpus' is set, even though
no entries were actually matched.  Then, when the MADT is iterated
with acpi_parse_x2apic(), the x2apic entries with ids less than 255
are skipped and most of my CPUs aren't recognized.

I think the original version of this change was okay for this case in
https://lore.kernel.org/lkml/87pm4bp54z.ffs@tglx/T/

P.S. I could be convinced that the MADT for my platform is somewhat
ill-formed and that I'm relying on pre-existing behavior.  I'm not
well-versed enough in the topic to know for sure.
