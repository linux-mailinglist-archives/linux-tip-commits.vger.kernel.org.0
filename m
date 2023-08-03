Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BD176F4E5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Aug 2023 23:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjHCV4v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Aug 2023 17:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHCV4t (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Aug 2023 17:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAA62D7E
        for <linux-tip-commits@vger.kernel.org>; Thu,  3 Aug 2023 14:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691099761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KM8Vigl0h9QVHeYdLXISDzZx4epLj9fcgIeYJK+1hsU=;
        b=UwqDAVcBgLCll0fZ76oOwxOE/ym/RDKfH6MjdUnUCwwo2x4FfQdoNXp3U7JzHywI6UyS2U
        yXL6rNm1ElT1NxDOktJy9CbNNPQTW3icXc/L2+nrPvN6HI61OPj6vxGn/9B8c/+8T/C49E
        F1z3e3sze/il1jvlIhk7uKVVsgaahNA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-Q6jZ1CgdNamR45o91H29dw-1; Thu, 03 Aug 2023 17:55:59 -0400
X-MC-Unique: Q6jZ1CgdNamR45o91H29dw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76c81b2cf8bso162892485a.3
        for <linux-tip-commits@vger.kernel.org>; Thu, 03 Aug 2023 14:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691099759; x=1691704559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM8Vigl0h9QVHeYdLXISDzZx4epLj9fcgIeYJK+1hsU=;
        b=JX6bWlEajW05je/+Cl2cn6Yn3/F1UxHTrovEEFVVNip3Rspn47KVhx01gIZlBh/0Ry
         VfpVSznWcG6Q4gbdEwf8MfBqslhjGdgfsp84XUukyNMVDvwwwFcBIVvJ7K7hGrFKRLqi
         QfpJE5VlFlBuGQSRyBh+MXEQsdGXQOnld2v0cnoJboheUml9HTNWh8R5ODaw2DOL+yCp
         1l74hdHY4OqmO+U92r+Ufcv0JUEVBmmynYvRT1824D3xApmSTYTDQqfg4Worv9xY16Ts
         PXFOD63kVZ8l3+MWfJZKhZeAH7k2+Vh3C21N0AQB34TisMk8zhqcZxntEoiRbl8Jo2Mf
         f1uQ==
X-Gm-Message-State: AOJu0YwGdmP111VzL34d75phg8gtgD7XBOhuFr/e7o7FAVHnOGcRnGU7
        GnnosUPLQy/Sg7VSnR1U6oBzib31oj3Eh9cFXBEzU/cwHN8gthg4UOHAN5AgkJS7tHzMUdZxsNr
        bjwDRJhnYXPJn+mBHsUuZUWRbIXeziNM=
X-Received: by 2002:a05:620a:31a6:b0:76c:a659:5ed8 with SMTP id bi38-20020a05620a31a600b0076ca6595ed8mr27579qkb.10.1691099758943;
        Thu, 03 Aug 2023 14:55:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoIExBmpCGcB5Ujy49S5j2ELer/eE6FTmCA1IE4XqBWVfbQwo9zmA6CbU1bkSRxRP/ULAwsw==
X-Received: by 2002:a05:620a:31a6:b0:76c:a659:5ed8 with SMTP id bi38-20020a05620a31a600b0076ca6595ed8mr27567qkb.10.1691099758704;
        Thu, 03 Aug 2023 14:55:58 -0700 (PDT)
Received: from treble ([199.195.15.105])
        by smtp.gmail.com with ESMTPSA id a4-20020a05620a124400b0076c71c1d2f5sm208712qkl.34.2023.08.03.14.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 14:55:58 -0700 (PDT)
Date:   Thu, 3 Aug 2023 16:55:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     tip-bot2 for Petr Pavlu <tip-bot2@linutronix.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/core] x86/retpoline,kprobes: Fix position of thunk
 sections with CONFIG_LTO_CLANG
Message-ID: <20230803215555.zl5oabntc44ry3uc@treble>
References: <20230711091952.27944-2-petr.pavlu@suse.com>
 <169098679602.28540.7005603884356771970.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169098679602.28540.7005603884356771970.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Aug 02, 2023 at 02:33:16PM -0000, tip-bot2 for Petr Pavlu wrote:
> The following commit has been merged into the x86/core branch of tip:
> 
> Commit-ID:     973ab2d61f33dc85212c486e624af348c4eeb5c9
> Gitweb:        https://git.kernel.org/tip/973ab2d61f33dc85212c486e624af348c4eeb5c9
> Author:        Petr Pavlu <petr.pavlu@suse.com>
> AuthorDate:    Tue, 11 Jul 2023 11:19:51 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Wed, 02 Aug 2023 16:27:07 +02:00
> 
> x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG
> 

[...]

> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -389,7 +389,7 @@ static int decode_instructions(struct objtool_file *file)
>  		if (!strcmp(sec->name, ".noinstr.text") ||
>  		    !strcmp(sec->name, ".entry.text") ||
>  		    !strcmp(sec->name, ".cpuidle.text") ||
> -		    !strncmp(sec->name, ".text.__x86.", 12))
> +		    !strncmp(sec->name, ".text..__x86.", 12))

Andy Cooper reported this should be 13.

-- 
Josh

